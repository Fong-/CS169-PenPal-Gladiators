require "spec_helper"
require "json"

describe TopicsController do
    before :each do
        @topicA = Topic.create(:name => "TopicA", :icon => "/some/path/topic_a.png")
        @topicB = Topic.create(:name => "TopicB", :icon => "/some/path/topic_b.png")
        @topicC = Topic.create(:name => "TopicC", :icon => "/some/path/topic_c.png")
        @topicD = Topic.create(:name => "TopicD", :icon => "/some/path/topic_d.png")
        @topicE = Topic.create(:name => "TopicE", :icon => "/some/path/topic_e.png")
        @lastTopicId = @topicE.id
    end

    it "should return all topics" do
        get "get_all"
        responseObject = JSON.parse(response.body).sort { |u, v| u["id"] <=> v["id"] }
        expect(responseObject.length).to equal(5)
        expect(responseObject[0]["name"]).to eq("TopicA")
        expect(responseObject[1]["name"]).to eq("TopicB")
        expect(responseObject[2]["name"]).to eq("TopicC")
        expect(responseObject[3]["name"]).to eq("TopicD")
        expect(responseObject[4]["name"]).to eq("TopicE")
    end

    it "should return a specific topic by id" do
        get "get_by_id", :id => "1"
        responseObject = JSON.parse(response.body)
        expect(responseObject["name"]).to eq("TopicA")
        expect(responseObject["id"]).to eq(1)
        expect(responseObject["icon"]).to eq("/some/path/topic_a.png")
    end

    it "should return an error if the given id has no corresponding topic" do
        get "get_by_id", :id => "100"
        responseObject = JSON.parse(response.body)
        expect(responseObject["error"]).to equal(true)
    end
end
