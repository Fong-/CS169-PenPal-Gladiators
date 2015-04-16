require 'spec_helper'

describe User do
    context "rank and match users" do
        before :each do
            users = [
                {
                    :email => "ben@bitdiddle.com",
                },
                {
                    :email => "generic@email.com"
                },
                {
                    :email => "rosenthal@policy.com",
                }
            ]

            users.each do |u|
                User.create!(u)
            end
            
            responses = [
                { :text => "Yes", :index => 0 },
                { :text => "No", :index => 1}
            ]

            topics = [
                { :name => "Climate" },
                { :name => "Philosophy" }
            ]

            topics.each do |t|
                topic = Topic.create!(t)

                survey_question1 = topic.survey_questions.create(:text => "Do you hate #{topic.name}?", :index => 1)
                survey_question2 = topic.survey_questions.create(:text => "Do you care about #{topic.name}?", :index => 3)
                created_responses = []
                
                responses.each do |r|
                    verb1 = r[:text] == "Yes" ? "hate" : "don't hate"
                    verb2 = r[:text] == "Yes" ? "care" : "don't care"
                    actual_response1 = r.clone
                    actual_response2 = r.clone
                    actual_response1[:summary_text] = "I #{verb1} #{topic.name}."
                    actual_response2[:summary_text] = "I #{verb2} about #{topic.name}."
                    created_responses.push(survey_question1.survey_responses.create(actual_response1))
                    created_responses.push(survey_question2.survey_responses.create(actual_response2))
                end
                
                ResponseWeight.create({:response1_id => created_responses[0].id, :response2_id => created_responses[1].id, :weight => 5})
                ResponseWeight.create({:response1_id => created_responses[0].id, :response2_id => created_responses[2].id, :weight => 1})
                ResponseWeight.create({:response1_id => created_responses[0].id, :response2_id => created_responses[3].id, :weight => 1})
                ResponseWeight.create({:response1_id => created_responses[1].id, :response2_id => created_responses[2].id, :weight => 1})
                ResponseWeight.create({:response1_id => created_responses[1].id, :response2_id => created_responses[3].id, :weight => 1})
                ResponseWeight.create({:response1_id => created_responses[2].id, :response2_id => created_responses[3].id, :weight => 1})

            end

            ben = User.find_by_email("ben@bitdiddle.com")
            response = Topic.find_by_name("Climate").survey_questions.find_by_index(1).survey_responses.find_by_index(0)
            UserSurveyResponse.create(:user => ben, :survey_response => response)

            nick = User.find_by_email("generic@email.com")
            response = Topic.find_by_name("Philosophy").survey_questions.find_by_index(1).survey_responses.find_by_index(1)
            UserSurveyResponse.create(:user => nick, :survey_response => response)

            rosenthal = User.find_by_email("rosenthal@policy.com")
            response = Topic.find_by_name("Climate").survey_questions.find_by_index(1).survey_responses.find_by_index(1)
            UserSurveyResponse.create(:user => rosenthal, :survey_response => response)
        end
        
        it "should build a question-response hash" do
            expect(User.find_by_email("ben@bitdiddle.com").build_hash).to include("1" => 1)
        end
        
        it "should return the correct topic score" do
            expect(User.find_by_email("ben@bitdiddle.com").find_topic_score(User.find_by_email("rosenthal@policy.com"), Topic.find_by_name("Climate").id)).to eq(1)
            expect(User.find_by_email("rosenthal@policy.com").find_topic_score(User.find_by_email("ben@bitdiddle.com"), Topic.find_by_name("Climate").id)).to eq(1)
        end
    
        it "should know the topics it answered" do
            expect(User.find_by_email("ben@bitdiddle.com").find_topics).to include(Topic.find_by_name("Climate").id)
        end
        
        it "should find common topics" do
            expect(User.find_by_email("ben@bitdiddle.com").find_common_topics(User.find_by_email("rosenthal@policy.com"))).to include(Topic.find_by_name("Climate").id)
        end

        it "should score the other user" do
            expect(User.find_by_email("ben@bitdiddle.com").score_user(User.find_by_email("rosenthal@policy.com"))[:score]).to eq(1)
        end

        it "should return the correct matches" do
            expect(User.find_by_email("ben@bitdiddle.com").matches.first[:user].id).to eq User.find_by_email("rosenthal@policy.com").id
        end
    end
    
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
