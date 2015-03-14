require "spec_helper"
require "json"

describe SurveyResponsesController do
    before :each do
        @Topic = Topic.create({:name => "Generic Topic", :icon => "some/random/topic/icon.png"})
        @question = @Topic.survey_questions.create(:text => "What is the meaning of life?", :index => 1)
        @responseA = @question.survey_responses.create(:text => "Null Pointer Exception", :index => 0)
        @responseB = @question.survey_responses.create(:text => "42", :index => 1)
        @responseC = @question.survey_responses.create(:text => "Getting full RSpec coverage", :index => 2)
        @responseID = @responseA.id
    end

    it "should return all responses" do
        get "get_all"
        responseObject = JSON.parse(response.body).sort { |u, v| u["id"] <=> v["id"] }
        expect(responseObject.length).to equal(3)
        expect(responseObject[0]["text"]).to eq("Null Pointer Exception")
        expect(responseObject[1]["text"]).to eq("42")
        expect(responseObject[2]["text"]).to eq("Getting full RSpec coverage")
    end

    it "should return the right response for a given id" do
        get "get_by_id", :id => @responseID
        responseObject = JSON.parse(response.body)
        expect(responseObject["text"]).to eq("Null Pointer Exception")
        expect(responseObject["id"]).to eq(@responseID)
    end
end
