require 'spec_helper'

describe SurveyQuestion do
    context "when querying survey questions" do
        before :each do
            @topic = Topic.create! :name => "Climate"

            @question1 = @topic.survey_questions.create! :text => "Is Earth hot?"
            @question2 = @topic.survey_questions.create! :text => "Is CO2 good?"

            @question1.survey_responses.create! :text => "1"
            @question1.survey_responses.create! :text => "2"

            @question2.survey_responses.create! :text => "1"
        end

        it "should find the topic it belongs to" do
            expect(@question1.topic).to eq(@topic)
            expect(@question2.topic).to eq(@topic)
        end

        it "should find the responses it has" do
            expect(@question1.survey_responses).to have(2).responses
            expect(@question2.survey_responses).to have(1).response
        end
    end
end
