require "spec_helper"
require "json"

describe ConversationsController do
    context "#get_by_id" do
        before :each do
            @conversation = double "Conversation", :response_object => { :data => 1 }
        end

        it "should construct a response for the correct conversation" do
            Conversation.stub(:find_by_id).and_return(@conversation)
            expect(@conversation).to receive(:response_object).exactly(1).times
            get "get_by_id", :id => 1
            response_object = JSON.parse(response.body)
            expect(response_object["data"]).to eq(1)
        end

        it "should return an error response if no such conversation exists" do
            Conversation.stub(:find_by_id).and_return(nil)
            get "get_by_id", :id => 2
            response_object = JSON.parse(response.body)
            expect(response_object["error"]).to eq("No such conversation.")
            expect(response_object["id"]).to eq(nil)
            expect(response_object["title"]).to eq(nil)
            expect(response_object["posts"]).to eq(nil)
        end
    end
end
