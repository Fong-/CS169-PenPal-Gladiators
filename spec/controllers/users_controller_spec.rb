require 'digest'
require 'spec_helper'

describe UsersController, :type => :controller do
    before :each do
        @sha256 = Digest::SHA256.new
        User.create :email => "whsieh@berkeley.edu", :password => "asdfasdf"
    end

    it "should complain if no email or password is given" do
        post "login", { :email => "", :password => "foo"}
        responseObject = JSON.parse(response.body)
        expect(responseObject["error"]).not_to eq(nil)
        expect(responseObject["error"]).to eq("invalid email")
        post "login", { :email => "foo", :password => ""}
        responseObject = JSON.parse(response.body)
        expect(responseObject["error"]).not_to eq(nil)
        expect(responseObject["error"]).to eq("invalid password")
    end

    it "should not authenticate a user with incorrect credentials" do
        post "login", { :email => "foo@bar.com", :password => "helloworld" }
        responseObject = JSON.parse(response.body)
        expect(responseObject["error"]).not_to eq(nil)
        expect(responseObject["error"]).to eq("incorrect credentials")
        post "login", { :email => "whsieh@berkeley.edu", :password => "helloworld" }
        responseObject = JSON.parse(response.body)
        expect(responseObject["error"]).not_to eq(nil)
        expect(responseObject["error"]).to eq("incorrect credentials")
    end

    it "should authenticate a user with correct credentials" do
        post "login", { :email => "whsieh@berkeley.edu", :password => "asdfasdf" }
        responseObject = JSON.parse(response.body)
        expect(responseObject["error"]).to eq(nil)
        expect(responseObject["success"]).to eq("true")
    end

    it "should prevent an existing user from registering" do
        get "can_register", { :email => "whsieh@berkeley.edu", :password => "asdfasdf" }
        responseObject = JSON.parse(response.body)
        expect(responseObject["error"]).not_to eq(nil)
        expect(responseObject["error"]).to eq("email already exists")
    end

    it "should not allow a user to register without a password or email" do
        get "can_register", { :email => "kevin.wu@berkeley.edu", :password => "" }
        responseObject = JSON.parse(response.body)
        expect(responseObject["error"]).not_to eq(nil)
        expect(responseObject["error"]).to eq("invalid password")
        get "can_register", { :email => "", :password => "asdfasdf" }
        responseObject = JSON.parse(response.body)
        expect(responseObject["error"]).not_to eq(nil)
        expect(responseObject["error"]).to eq("invalid email")
    end

    it "should allow a user to register with a new email and password" do
        get "can_register", { :email => "kevin.wu@berkeley.edu", :password => "asdfasdf" }
        responseObject = JSON.parse(response.body)
        expect(responseObject["error"]).to eq(nil)
        expect(responseObject["success"]).to eq("true")
    end

    it "should register a new user given an email and password" do
        post "register", { :email => "kevin.wu@berkeley.edu", :password => "asdfasdf" }
        expect(User.all.length).to eq(2)
        kevin = User.find_by_email("kevin.wu@berkeley.edu")
        expect(kevin.password).to eq(@sha256.base64digest("asdfasdf"))
    end
end
