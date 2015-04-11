require 'digest'
require 'spec_helper'

describe UsersController, :type => :controller do

    context "when finding matches" do
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
        
        it "should return the correct matches" do
            get "matches", :id => User.find_by_email("ben@bitdiddle.com").id
            responseObject = JSON.parse(response.body)
            expect(responseObject.first["user"]["id"]).to eq User.find_by_email("rosenthal@policy.com").id
        end
    end
    
    context "when accessing a user's profile information" do
        before :each do
            controller.stub(:check_access_token).and_return(true)
        end

        it "should return the appropriate response object" do
            user = double(user, :profile_response_object => {:a => 1})
            User.stub(:find_by_id).and_return(user)
            expect(user).to receive(:profile_response_object).once
            get "get_profile_info_by_id", :id => 1
        end

        it "should update the user profile" do
            user = double(user, :update_profile => nil)
            User.stub(:find_by_id).and_return(user)
            expect(user).to receive(:update_profile).once
            post "post_profile_info_by_id",  :id => 1
        end
    end

    context "when authenticating a user" do
        before :each do
            @user = User.create :email => "alice@example.com", :password => "12345678"
            @access_token = @user.access_token
        end

        it "should accept a valid access token" do
            post "authenticate", { :token => @access_token }
            responseObject = JSON.parse(response.body)
            expect(responseObject["user"]).not_to be(nil)
        end

        it "should return the user response object" do
            user = double(user, :response_object => {})
            User.stub(:parse_access_token).and_return({ :user => user })
            expect(user).to receive(:response_object)
            post "authenticate", { :token => @access_token }
        end

        it "should complain if authenticated with an invalid access token" do
            prev_secret = @user.secret
            @user.secret = "random string"
            bad_access_token = @user.access_token
            @user.secret = prev_secret

            post "authenticate", { :token => bad_access_token }
            responseObject = JSON.parse(response.body)
            expect(responseObject["error"]).not_to eq(nil)
            expect(response.status).to eq(401)
        end

        it "should complain if authenticated with a malformed access token" do
           post "authenticate", { :token => "abcd" }
            responseObject = JSON.parse(response.body)
            expect(responseObject["error"]).not_to eq(nil)
            expect(response.status).to eq(401)
        end

    end

    context "when logging in or registering a user" do
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
            expect(response.status).to eq(404)
            post "login", { :email => "alice@example.com", :password => "helloworld" }
            responseObject = JSON.parse(response.body)
            expect(responseObject["error"]).not_to eq(nil)
            expect(response.status).to eq(404)
        end

        it "should login a user with correct credentials" do
            post "login", { :email => "alice@example.com", :password => "12345678" }
            responseObject = JSON.parse(response.body)
            expect(responseObject["error"]).to eq(nil)
        end

        it "should not login an unknown user" do
            get "login", { :email => "bob@example.com", :password => "12345678" }
            responseObject = JSON.parse(response.body)
            expect(responseObject["error"]).not_to eq(nil)
            expect(response.status).to eq(404)
            expect(responseObject["token"]).to eq(nil)
        end

        it "should prevent an existing user from registering" do
            get "can_register", { :email => "alice@example.com", :password => "12345678" }
            responseObject = JSON.parse(response.body)
            expect(responseObject["error"]).not_to eq(nil)
            expect(response.status).to eq(400)
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
