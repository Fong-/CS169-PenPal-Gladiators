require 'spec_helper'

describe ResponseWeight do
    context "find response score" do
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
                { :name => "Philosophy" },
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
        
        it "should return the correct score given two responses" do
            expect(ResponseWeight.find_weight(1, 2)).to eq(5)
        end
    end
end
