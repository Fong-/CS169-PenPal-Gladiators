require 'spec_helper'

describe Conversation do
    context "when using a conversation instance" do
        before :each do
            @conversation = Conversation.create! :title => "Happy feet"
            @post1 = @conversation.posts.create! :text => "Lalalala"
            @post2 = @conversation.posts.create! :text => "Good conversation"
        end

        it "should return the most recent post" do
            expect(@conversation.recent_post).to eq(@post2)
        end

        it "should return the appropriate update time" do
            expect(@conversation.timestamp).to eq(@conversation.updated_at)
        end
    end
end
