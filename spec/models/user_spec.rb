require 'spec_helper'

describe User do
    context "when created without a username" do
        it "should have a generated username" do
            UsernameGenerator.stub(:new).and_return("RandomName")
            expect(User.new.username).to eq("RandomName")
        end
    end

    context "when created without a secret" do
        it "should have a generated secret" do
            SecureRandom.stub(:base64).and_return("1234")
            expect(User.new.secret).to eq("1234")
        end
    end

    context "when accessing user information" do
        before :each do
            @info = {
                :username => "Butterfly",
                :avatar => "image.png",
                :political_blurb => "I am cool",
                :political_hero => "Leo",
                :political_spectrum => 3
            }

            @user = User.create!(@info)
        end

        it "should return the appropriate response object" do
            response = @user.response_object
            expect(response).to eq({ :username => "Butterfly", :avatar => "image.png", :id => @user.id })
        end
    end

    context "when accessing the profile information" do
        before :each do
            @profile_info = {
                :username => "Butterfly",
                :avatar => "image.png",
                :political_blurb => "I am cool",
                :political_hero => "Leo",
                :political_spectrum => 3
            }

            @user = User.create!(@profile_info)
        end

        it "should return the appropriate profile information" do
            response = @user.profile_response_object
            expect(response).to eq(@profile_info)
        end

        it "should update the profile information appropriately" do
            @profile_info[:username] = "Mad man"
            @profile_info[:political_spectrum] = 2
            @user.update_profile(@profile_info)
            expect(@user.profile_response_object).to eq(@profile_info)
        end
    end
end
