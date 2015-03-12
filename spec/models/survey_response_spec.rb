require 'spec_helper'

describe SurveyResponse do
    context "when querying survey responses" do
        before :each do
            @kevin = User.create! :email => "Kevin"
            @wenson = User.create! :email => "Wenson"

            question1 = SurveyQuestion.create! :text => "Do you like C++?"
            question2 = SurveyQuestion.create! :text => "Do you like Java?"

            @yes1 = question1.survey_responses.create! :text => "Yes"
            @no1 = question1.survey_responses.create! :text => "No"

            @yes2 = question2.survey_responses.create! :text => "Yes"
            @no2 = question2.survey_responses.create! :text => "No"

            UserSurveyResponse.create! :user => @kevin, :survey_response => @yes1
            UserSurveyResponse.create! :user => @kevin, :survey_response => @no2

            UserSurveyResponse.create! :user => @wenson, :survey_response => @no1
            UserSurveyResponse.create! :user => @wenson, :survey_response => @no2
        end

        it "should find the users that answered with the response" do
            expect(@yes1.users).to include(@kevin)
            expect(@yes1.users).not_to include(@wenson)
            expect(@no2.users).to include(@kevin, @wenson)
            expect(@no1.users).to include(@wenson)
            expect(@no1.users).not_to include(@kevin)
            expect(@yes2.users).to have(0).users
        end

        it "should find the question it belongs to" do
           expect(@yes1.survey_question.text).to eq("Do you like C++?")
           expect(@no1.survey_question.text).to eq("Do you like C++?")
           expect(@yes2.survey_question.text).to eq("Do you like Java?")
           expect(@no2.survey_question.text).to eq("Do you like Java?")
        end
    end
end
