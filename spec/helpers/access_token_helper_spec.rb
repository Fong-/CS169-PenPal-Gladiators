require "spec_helper"

describe AccessTokenHelper do

    before :each do
        @sha256 = Digest::SHA256.new
        @user = User.create :email => "whsieh@berkeley.edu", :password => @sha256.base64digest("asdfasdf")
        @secret = @user.secret
    end

    it "should not authenticate an unknown user" do
        fake_user = User.new :email => "a@b.com", :password => @sha256.base64digest("foobar")
        token = fake_user.access_token(3.days)
        result = User.parse_access_token(token)
        expect(result[:error]).to eq(:no_such_user)
        expect(result[:expiration_time]).to eq(nil)
    end

    it "should check authenticate a valid access token" do
        token = @user.access_token(3.days)
        result = User.parse_access_token(token)
        expect(result[:error]).to eq(nil)
        expect(result[:user]).to eq(@user)
        expect(result[:expiration_time].to_s).to eq(Time.at(3.days.from_now).to_s)
    end

    it "should not authenticate an expired access token" do
        token = @user.access_token(3.days)
        Timecop.freeze(4.days.from_now)
        result = User.parse_access_token(token)
        Timecop.return
        expect(result[:error]).to eq(:expired_token)
        expect(result[:expiration_time]).to eq(nil)
        expect(result[:user]).to eq(@user)
    end

    it "should not authenticate an invalid access token" do
        token = @user.access_token(3.days)
        result = User.parse_access_token(token + "foo")
        expect(result[:error]).to eq(:invalid_token)
        expect(result[:expiration_time]).to eq(nil)
        expect(result[:user]).to eq(@user)
    end
end
