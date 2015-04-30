require "spec_helper"
require "json"

describe ConversationsController do
    context "#get_by_id" do
        before :each do
            @conversation = double "Conversation", :response_object => { :data => 1 }
            controller.stub(:check_access_token).and_return(true)
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
            expect(response_object["error"]).not_to be(nil)
            expect(response_object["id"]).to eq(nil)
            expect(response_object["title"]).to eq(nil)
            expect(response_object["posts"]).to eq(nil)
            expect(response.status).to eq(404)
        end
    end

    context "#edit_summary" do
        before :each do
            controller.stub(:check_access_token).and_return(true)
            @me = double "the user", :id => 1
            @token_results = { :user => @me }
            controller.instance_variable_set(:@token_results, @token_results)
        end

        it "should allow users to edit opposing summaries" do
            conversation = double "Conversation", :user_did_edit_summary => true
            Conversation.stub(:find_by_id).and_return conversation
            expect(conversation).to receive(:user_did_edit_summary).exactly(1).times
            post "edit_summary", :user_id => 1, :conversation_id => 1, :text => "I am Ben and I am summarizing Bob."
            response_object = JSON.parse(response.body)
            expect(response_object["success"]).to eq "successfully edited summary"
        end

        it "should return an error if no such conversation exists" do
            Conversation.stub(:find_by_id).and_return nil
            post "edit_summary", :user_id => 1, :conversation_id => 1, :text => "I am Ben and I am summarizing Bob."
            response_object = JSON.parse(response.body)
            expect(response_object["error"]).to eq "no such conversation or user"
        end

        it "should return an error if the summary could not be edited" do
            conversation = double "Conversation", :user_did_edit_summary => false
            Conversation.stub(:find_by_id).and_return conversation
            post "edit_summary", :user_id => 1, :conversation_id => 1, :text => "I am Ben and I am summarizing Bob."
            response_object = JSON.parse(response.body)
            expect(response_object["error"]).to eq "you are not allowed to do this"
        end
    end

    context "#approve_summary" do
        before :each do
            controller.stub(:check_access_token).and_return(true)
            @me = double "the user", :id => 1
            @token_results = { :user => @me }
            controller.instance_variable_set(:@token_results, @token_results)
        end

        it "should allow users to approve opposing summaries" do
            conversation = double "Conversation", :user_did_approve_summary => true
            Conversation.stub(:find_by_id).and_return conversation
            expect(conversation).to receive(:user_did_approve_summary).exactly(1).times
            post "approve_summary", :user_id => 1, :conversation_id => 1
            response_object = JSON.parse(response.body)
            expect(response_object["success"]).to eq "successfully approved summary"
        end

        it "should return an error if no such conversation exists" do
            Conversation.stub(:find_by_id).and_return nil
            post "approve_summary", :user_id => 1, :conversation_id => 1
            response_object = JSON.parse(response.body)
            expect(response_object["error"]).to eq "no such conversation or user"
        end

        it "should return an error if the summary could not be approved" do
            conversation = double "Conversation", :user_did_approve_summary => false
            Conversation.stub(:find_by_id).and_return conversation
            post "approve_summary", :user_id => 1, :conversation_id => 1
            response_object = JSON.parse(response.body)
            expect(response_object["error"]).to eq "you are not allowed to do this"
        end
    end

    context "#edit_resolution" do
        before :each do
            controller.stub(:check_access_token).and_return(true)
            @me = double "the user", :id => 1
            @token_results = { :user => @me }
            controller.instance_variable_set(:@token_results, @token_results)
        end

        it "should allow users to edit the resolution" do
            conversation = double "Conversation", :user_did_edit_resolution => true
            Conversation.stub(:find_by_id).and_return conversation
            expect(conversation).to receive(:user_did_edit_resolution).exactly(1).times
            post "edit_resolution", :user_id => 1, :conversation_id => 1, :text => "I am Ben and I am writing a resolution."
            response_object = JSON.parse(response.body)
            expect(response_object["success"]).to eq "successfully edited resolution"
        end

        it "should return an error if no such conversation exists" do
            Conversation.stub(:find_by_id).and_return nil
            post "edit_resolution", :user_id => 1, :conversation_id => 1, :text => "I am Ben and I am writing a resolution."
            response_object = JSON.parse(response.body)
            expect(response_object["error"]).to eq "no such conversation or user"
        end

        it "should return an error if the summary could not be edited" do
            conversation = double "Conversation", :user_did_edit_resolution => false
            Conversation.stub(:find_by_id).and_return conversation
            post "edit_resolution", :user_id => 1, :conversation_id => 1, :text => "I am Ben and I am writing a resolution."
            response_object = JSON.parse(response.body)
            expect(response_object["error"]).to eq "you are not allowed to do this"
        end
    end

    context "#approve_resolution" do
        before :each do
            controller.stub(:check_access_token).and_return(true)
            @me = double "the user", :id => 1
            @token_results = { :user => @me }
            controller.instance_variable_set(:@token_results, @token_results)
        end

        it "should allow users to approve opposing resolutions" do
            conversation = double "Conversation", :user_did_approve_resolution => true
            Conversation.stub(:find_by_id).and_return conversation
            expect(conversation).to receive(:user_did_approve_resolution).exactly(1).times
            post "approve_resolution", :user_id => 1, :conversation_id => 1
            response_object = JSON.parse(response.body)
            expect(response_object["success"]).to eq "successfully approved resolution"
        end

        it "should return an error if no such conversation exists" do
            Conversation.stub(:find_by_id).and_return nil
            post "approve_resolution", :user_id => 1, :conversation_id => 1
            response_object = JSON.parse(response.body)
            expect(response_object["error"]).to eq "no such conversation or user"
        end

        it "should return an error if the resolution could not be approved" do
            conversation = double "Conversation", :user_did_approve_resolution => false
            Conversation.stub(:find_by_id).and_return conversation
            post "approve_resolution", :user_id => 1, :conversation_id => 1
            response_object = JSON.parse(response.body)
            expect(response_object["error"]).to eq "you are not allowed to do this"
        end
    end

    context "#edit_title" do
        before :each do
            controller.stub(:check_access_token).and_return(true)
            arena = double "Arena", :user1_id => 1, :user2_id => 2
            @conversation = double "Conversation", :update_column => nil, :arena => arena
            Conversation.stub(:find_by_id).and_return @conversation
        end

        it "should return an error if the title could not be edited" do
            @me = double "the user", :id => 100000
            @token_results = { :user => @me }
            controller.instance_variable_set(:@token_results, @token_results)
            post "edit_title", :conversation_id => 1, :text => "Hello world"
            response_object = JSON.parse(response.body)
            expect(response_object["error"]).to_not eq nil
        end

        it "should allow the user to edit the title" do
            @me = double "the user", :id => 1
            @token_results = { :user => @me }
            controller.instance_variable_set(:@token_results, @token_results)
            expect(@conversation).to receive(:update_column).exactly(1).times
            post "edit_title", :conversation_id => 1, :text => "Hello world"
            response_object = JSON.parse(response.body)
            expect(response_object["error"]).to eq nil
        end
    end

    context "#get_with_resolutions" do
        it "should return recent conversations with resolutions" do
            controller.stub(:check_access_token).and_return(true)
            conv1 = double "first conversation", :title => "first", :resolution => "first resolution"
            conv2 = double "second conversation", :title => "second", :resolution => "second resolution"
            Conversation.stub(:recent_with_resolutions).and_return([conv1, conv2])
            get "get_with_resolutions"
            response_object = JSON.parse(response.body)
            expect(response_object["conversations"]).to_not eq nil
            convos = response_object["conversations"]
            expect(convos.length).to eq 2
            expect(convos[0]).to eq({ "title" => "first", "resolution" => "first resolution" })
            expect(convos[1]).to eq({ "title" => "second", "resolution" => "second resolution" })
        end
    end
end
