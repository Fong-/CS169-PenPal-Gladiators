require 'spec_helper'

describe Post do
    context "when using a conversation instance" do
        before :each do
            ben = User.create! :email => "ben@bitdiddle.com", :password => "asdfasdf"
            @conversation = Conversation.create! :title => "Happy feet"
            Timecop.freeze Time.now
            @post = @conversation.posts.create! :text => "Wombo combo", :author => ben
            Timecop.return
        end

        it "should have the appropriate response object" do
            result = @post.response_object
            expect(result[:id]).to eq(@post.id)
            expect(result[:author]).to_not eq(nil)
            expect(result[:text]).to eq(@post.text)
            expect(String(result[:timestamp])).to eq(String(@post.updated_at))
        end
    end
end
