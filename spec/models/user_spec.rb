require 'spec_helper'

describe User do
    context "rank and match users" do
        before :each do
            users = [
                {
                    :email => "ben@bitdiddle.com",
                    :password => "bitsrocks",
                    :username => "ben",
                    :avatar => "/path/to/ben.png",
                    :political_blurb => "I like Ron Bitdiddle",
                    :political_hero => "Ron Bitdiddle",
                    :political_spectrum => 2 },
                {
                    :email => "generic@email.com",
                    :password => "asdfasdf",
                    :username => "generic",
                    :avatar => "/path/to/generic.png",
                    :political_blurb => "Go generic party!",
                    :political_hero => "Generic George",
                    :political_spectrum => 1 },
                {
                    :email => "bob@schmitt.com",
                    :password => "imboring",
                    :username => "bob",
                    :avatar => "/path/to/bob.png",
                    :political_blurb => "Bob for county clerk!",
                    :political_hero => "ME!",
                    :political_spectrum => 3 },
                {
                    :email => "genericasiankid@gmail.com",
                    :password => "password",
                    :username => "generickid",
                    :avatar => "/path/to/generickid.png",
                    :political_blurb => "Bob embezzles from widget farmers!",
                    :political_hero => "Not Bob!",
                    :political_spectrum => 1 },
                {
                    :email => "rosenthal@policy.com",
                    :password => "publicpolicy",
                    :username => "rosenthal",
                    :avatar => "/path/to/rosenthal.png",
                    :political_blurb => "Discuss your view on PenPal Gladiators!",
                    :political_hero => "Thomas Jefferson",
                    :political_spectrum => 2 }
            ]

            users.each do |u|
                User.create!(u)
            end

            ############################################################
            # Survey Topics, Questions, and Responses
            ############################################################

            responses = [
                { :text => "Yes", :index => 0 },
                { :text => "No", :index => 1}
            ]

            topics = [
                { :name => "Climate", :icon => "/assets/topic_icons/climate.png"},
                { :name => "Education", :icon => "/assets/topic_icons/education.png"},
                { :name => "Economy", :icon => "/assets/topic_icons/money.png"},
                { :name => "Technology", :icon => "/assets/topic_icons/technology.png"},
                { :name => "LGBT Rights", :icon => "/assets/topic_icons/lgbt.png"},
                { :name => "Immigration", :icon => "/assets/topic_icons/immigration.png"},
                { :name => "Foreign Policy", :icon => "/assets/topic_icons/international.png"},
                { :name => "Religion", :icon => "/assets/topic_icons/religion.png"},
                { :name => "Philosophy", :icon => "/assets/topic_icons/philosophy.png"},
                { :name => "Criminal Law", :icon => "/assets/topic_icons/justice.png"},
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

            #More complicated responses
            responses = [
                {
                    :text => "Education in the US is the best",
                    :summary_text => "I believe that education in the US is the best.",
                    :index => 2
                },
                {
                    :text => "Need to fund education less",
                    :summary_text => "I believe that we need to fund education less.",
                    :index => 1
                },
                {
                    :text => "Need more focus on STEM",
                    :summary_text => "I believe that there needs to be more focus on STEM.",
                    :index => 0
                },
                {
                    :text => "Too many college grads, need to raise tuition fee",
                    :summary_text => "I believe that there are too many college gradudates, therefore, we need to raise the tuition fees.",
                    :index => 3
                }
            ]

            education = Topic.find_by_name("Education")
            survey_question = education.survey_questions.create(:text => "What's your view on US higher education?", :index => 2)
            responses.each do |r|
                survey_question.survey_responses.create(r)
            end

            ############################################################
            # Users <-> survey responses through user survey responses
            ############################################################


            ben = User.find_by_email("ben@bitdiddle.com")
            response = Topic.find_by_name("Climate").survey_questions.find_by_index(1).survey_responses.find_by_index(0)
            UserSurveyResponse.create(:user => ben, :survey_response => response)

            nick = User.find_by_email("generic@email.com")
            response = Topic.find_by_name("Philosophy").survey_questions.find_by_index(1).survey_responses.find_by_index(1)
            UserSurveyResponse.create(:user => nick, :survey_response => response)

            bob = User.find_by_email("bob@schmitt.com")
            response = Topic.find_by_name("Philosophy").survey_questions.find_by_index(1).survey_responses.find_by_index(0)
            UserSurveyResponse.create(:user => bob, :survey_response => response)

            wenson = User.find_by_email("genericasiankid@gmail.com")
            response = Topic.find_by_name("Education").survey_questions.find_by_index(1).survey_responses.find_by_index(1)
            UserSurveyResponse.create(:user => wenson, :survey_response => response)

            rosenthal = User.find_by_email("rosenthal@policy.com")
            response = Topic.find_by_name("Climate").survey_questions.find_by_index(1).survey_responses.find_by_index(1)
            UserSurveyResponse.create(:user => rosenthal, :survey_response => response)
        end
        
        it "should build a question-response hash" do
            expect(User.find_by_email("ben@bitdiddle.com").build_hash).to include("1" => 1)
        end
        
        it "should return the correct topic score" do
            expect(User.find_by_email("ben@bitdiddle.com").find_topic_score(User.find_by_email("rosenthal@policy.com"), Topic.find_by_name("Climate").id)).to eq(1)
            expect(User.find_by_email("generic@email.com").find_topic_score(User.find_by_email("rosenthal@policy.com"), Topic.find_by_name("Climate").id)).to eq(0)
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
