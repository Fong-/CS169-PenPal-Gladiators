require 'digest'
require 'spec_helper'

describe UsersController, :type => :controller do

    context "when accessing a user's profile information" do
        it "should return the appropriate response object" do
            user = double(user, :profile_response_object => {:a => 1})
            User.stub(:find).and_return(user)
            expect(user).to receive(:profile_response_object).once
            get "get_profile_info_by_id", :id => 1
        end

        it "should update the user profile" do
            user = double(user, :update_profile => nil)
            User.stub(:find).and_return(user)
            expect(user).to receive(:update_profile).once
            post "post_profile_info_by_id",  :id => 1
        end
    end

    context "when authenticating a user" do
        before :each do
            @sha256 = Digest::SHA256.new
            User.create :email => "alice@example.com", :password => "12345678"
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

        it "should not login a user with incorrect credentials" do
            post "login", { :email => "foo@bar.com", :password => "helloworld" }
            responseObject = JSON.parse(response.body)
            expect(responseObject["error"]).not_to eq(nil)
            expect(responseObject["error"]).to eq("incorrect credentials")
            post "login", { :email => "alice@example.com", :password => "helloworld" }
            responseObject = JSON.parse(response.body)
            expect(responseObject["error"]).not_to eq(nil)
            expect(responseObject["error"]).to eq("incorrect credentials")
        end

        it "should login a user with correct credentials" do
            post "login", { :email => "alice@example.com", :password => "12345678" }
            responseObject = JSON.parse(response.body)
            expect(responseObject["error"]).to eq(nil)
        end

        it "should not login an unknown user" do
            get "login", { :email => "bob@example.com", :password => "12345678" }
            responseObject = JSON.parse(response.body)
            expect(responseObject["error"]).to eq("incorrect credentials")
            expect(responseObject["token"]).to eq(nil)
        end

        it "should prevent an existing user from registering" do
            get "can_register", { :email => "alice@example.com", :password => "12345678" }
            responseObject = JSON.parse(response.body)
            expect(responseObject["error"]).not_to eq(nil)
            expect(responseObject["error"]).to eq("email already exists")
        end

        it "should not allow a user to register without a password or email" do
            get "can_register", { :email => "kevin.wu@example.com", :password => "" }
            responseObject = JSON.parse(response.body)
            expect(responseObject["error"]).not_to eq(nil)
            expect(responseObject["error"]).to eq("invalid password")
            get "can_register", { :email => "", :password => "12345678" }
            responseObject = JSON.parse(response.body)
            expect(responseObject["error"]).not_to eq(nil)
            expect(responseObject["error"]).to eq("invalid email")
        end

        it "should allow a user to register with a new email and password" do
            get "can_register", { :email => "bob@example.com", :password => "12345678" }
            responseObject = JSON.parse(response.body)
            expect(responseObject["error"]).to eq(nil)
        end

        it "should register a new user given an email and password" do
            post "register", { :email => "bob@example.com", :password => "12345678" }
            expect(User.all.length).to eq(2)
            kevin = User.find_by_email("bob@example.com")
            expect(kevin.password).to eq(@sha256.base64digest("12345678"))
        end
    end
end
