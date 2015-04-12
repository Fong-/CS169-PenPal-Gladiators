require "spec_helper"
require "json"

describe PostsController do
    before :each do
        user = User.create! :username => "ben", :email => "ben@bitdiddle.com", :password => "asdfasdf"
        User.stub(:find_by_id).and_return(user)
        @posts = double "posts", :create => nil
        @conversation = double "conversation", :posts => @posts
        controller.stub(:check_access_token).and_return(true)
    end

    context "when adding posts" do
        it "should not add a new post to a nonexistent conversation" do
            Conversation.stub(:find_by_id).and_return(nil)
            post "create", :conversation_id => 1, :text => "Hello world"
            response_object = JSON.parse(response.body)
            expect(response_object["error"]).to eq("No such conversation.")
        end

        it "should not add a new post without text" do
            Conversation.stub(:find_by_id).and_return(@conversation)
            post "create", :conversation_id => 1
            response_object = JSON.parse(response.body)
            expect(response_object["error"]).to eq("We couldn't parse your post!")
        end

        it "should add a new post" do
            Conversation.stub(:find_by_id).and_return(@conversation)
            post "create", :conversation_id => 1, :text => "Hello world!"
            response_object = JSON.parse(response.body)
            expect(response_object["error"]).to eq(nil)
            expect(response_object["success"]).to eq("Post successfully saved.")
        end
    end

    context "when editing posts" do
        it "should not edit an existing post without text" do
            post "edit", :post_id => 1
            response_object = JSON.parse(response.body)
            expect(response_object["error"]).to eq("We couldn't parse your post!")
        end

        it "should not edit a nonexistent post" do
            Post.any_instance.stub(:update).and_raise(ActiveRecord::RecordInvalid)
            post "edit", :post_id => 1, :text => "Hello world!"
            response_object = JSON.parse(response.body)
            expect(response_object["error"]).to eq("No such post.")
        end

        it "should edit an existing post" do
            Post.stub(:update).and_return(nil)
            post "edit", :post_id => 1, :text => "Hello world!"
            response_object = JSON.parse(response.body)
            expect(response_object["error"]).to eq(nil)
            expect(response_object["success"]).to eq("Post successfully saved.")
        end
    end
end
