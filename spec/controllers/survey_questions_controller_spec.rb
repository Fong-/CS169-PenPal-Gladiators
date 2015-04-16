require "spec_helper"
require "json"

describe SurveyQuestionsController do
    before :each do
        @Topic = Topic.create({:name => "Generic Topic", :icon => "some/random/topic/icon.png"})
        @questionOne = @Topic.survey_questions.create(:text => "What is the meaning of life?", :index => 1)
        @questionTwo = @Topic.survey_questions.create(:text => "Do you like writing code?", :index => 2)
        @questionThree = @Topic.survey_questions.create(:text => "Do you like writing tests for your code?", :index => 3)
        @questionFour = @Topic.survey_questions.create(:text => "Do you like dogs?", :index => 4)
        @questionFive = @Topic.survey_questions.create(:text => "Do you like cats?", :index => 5)
        @questionFive.survey_responses.create(:text => "Yep", :index => 0)
        @questionFive.survey_responses.create(:text => "Nope", :index => 1)
        @questionFiveID = @questionFive.id
    end

    it "should display all questions" do
        get "get_all"
        responseObject = JSON.parse(response.body).sort { |u, v| u["id"] <=> v["id"] }
        expect(responseObject.length).to equal(5)
        expect(responseObject[0]["text"]).to eq("What is the meaning of life?")
        expect(responseObject[1]["text"]).to eq("Do you like writing code?")
        expect(responseObject[2]["text"]).to eq("Do you like writing tests for your code?")
        expect(responseObject[3]["text"]).to eq("Do you like dogs?")
        expect(responseObject[4]["text"]).to eq("Do you like cats?")
    end

    it "should return a specific topic by id" do
        get "get_by_id", :id => "1"
        responseObject = JSON.parse(response.body)
        expect(responseObject["text"]).to eq("What is the meaning of life?")
        expect(responseObject["id"]).to eq(1)
    end

    it "should return an error if the given id has no corresponding question" do
        get "get_by_id", :id => "100"
        responseObject = JSON.parse(response.body)
        expect(responseObject).to include("error")
        expect(response.status).to equal(404)
    end

    it "should return correct responses for a question" do
        get "get_responses_by_id", :id => @questionFiveID
        responseObject = JSON.parse(response.body)
        expect(responseObject.length).to equal(2)
        expect(responseObject[0]["text"]).to eq("Yep")
        expect(responseObject[1]["text"]).to eq("Nope")
    end

    it "should return an error if the given id has no corresponding question" do
        get "get_responses_by_id", :id => 100
        responseObject = JSON.parse(response.body)
        expect(responseObject).to include("error")
        expect(response.status).to equal(404)
    end
end
