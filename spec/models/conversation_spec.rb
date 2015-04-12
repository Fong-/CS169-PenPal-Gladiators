require 'spec_helper'

describe Conversation do
    context "when using a conversation instance" do
        before :each do
            ben = User.create! :email => "ben@bitdiddle.com", :password => "asdfasdf"
            bob = User.create! :email => "bob@schmitt.com", :password => "asdfasdf"
            @conversation = Conversation.create! :title => "Happy feet"
            @post1 = @conversation.posts.create! :text => "Lalalala", :author => ben
            Timecop.freeze Time.now
            @post2 = @conversation.posts.create! :text => "Good conversation", :author => bob
            Timecop.return
        end

        it "should return the most recent post" do
            expect(@conversation.recent_post).to eq(@post2)
        end

        it "should return the appropriate update time" do
            expect(String(@conversation.timestamp)).to eq(String(@post2.updated_at))
        end

        it "should have the appropriate response object" do
            result = @conversation.response_object
            expect(result[:id]).to eq(@conversation.id)
            expect(result[:title]).to eq(@conversation.title)
            expect(result[:posts].length).to eq(@conversation.posts.length)
        end
    end
end
