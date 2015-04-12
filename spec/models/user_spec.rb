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

    context "when requesting the author of a post" do
        before :each do
            @user = User.create! :username => "ben bitdiddle", :avatar => "image.png", :email => "fu@bar.com"
        end

        it "should return relevant data for the author" do
            result = @user.post_author_response_object
            expect(result[:username]).to eq(@user.username)
            expect(result[:avatar]).to eq(@user.avatar)
            expect(result[:id]).to eq(@user.id)
        end
    end
end
