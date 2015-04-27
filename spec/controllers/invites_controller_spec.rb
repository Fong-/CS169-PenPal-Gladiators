require "spec_helper"
require "json"

describe InvitesController do
    context "#invite" do
        before :each do
            @me = double "the user", :present? => true, :id => 1
            @other = double "another user", :present? => true, :id => 2
            @token_results = { :user => @me }
            controller.instance_variable_set(:@token_results, @token_results)
            controller.stub(:check_access_token).and_return(true)
        end

        it "should respond with success when a new invite is created" do
            Invite.stub(:did_create_new_invite).and_return(true)
            User.stub(:find_by_id).and_return(@other)
            post "invite", :to_user => 2
            response_object = JSON.parse(response.body)
            expect(response_object["success"]).to_not eq nil
        end

        it "should respond with an error when a new invite cannot be created" do
            Invite.stub(:did_create_new_invite).and_return(false)
            User.stub(:find_by_id).and_return(@other)
            post "invite", :to_user => 2
            response_object = JSON.parse(response.body)
            expect(response_object["error"]).to_not eq nil
        end

        it "should respond with an error when inviting a nonexistent user" do
            Invite.stub(:did_create_new_invite).and_return(true)
            User.stub(:find_by_id).and_return(nil)
            post "invite", :to_user => 2
            response_object = JSON.parse(response.body)
            expect(response_object["error"]).to_not eq nil
        end
    end

    context "#outgoing" do
        before :each do
            @other = double "another user", :present? => true, :id => 2, :response_object => true
            Invite.stub(:all_users_invited_by).and_return([@other])
            @token_results = { :user => @me }
            controller.instance_variable_set(:@token_results, @token_results)
            controller.stub(:check_access_token).and_return(true)
        end

        it "should fetch a user's outgoing matches" do
            expect(@other).to receive(:response_object).once
            get "outgoing"
            response_object = JSON.parse(response.body)
            expect(response_object["outgoing"].length).to eq 1
        end
    end

    context "#incoming" do
        before :each do
            @me = double "the user", :present? => true, :id => 2, :response_object => true
            Invite.stub(:all_users_inviting).and_return([@me])
            @token_results = { :user => @me }
            controller.instance_variable_set(:@token_results, @token_results)
            controller.stub(:check_access_token).and_return(true)
        end

        it "should fetch a user's incoming matches" do
            expect(@me).to receive(:response_object).once
            get "incoming"
            response_object = JSON.parse(response.body)
            expect(response_object["incoming"].length).to eq 1
        end
    end

    context "#accept" do
        before :each do
            @me = double "the user", :present? => true, :id => 1
            @other = double "another user", :present? => true, :id => 2
            @token_results = { :user => @me }
            controller.instance_variable_set(:@token_results, @token_results)
            controller.stub(:check_access_token).and_return(true)
            @invite = double "invite", :reject => false
        end

        it "should not allow users to accept nonexistent invites" do
            Invite.stub(:pending_invite).and_return(nil)
            User.stub(:find_by_id).and_return(@other)
            post "accept", :from_user => 2
            response_object = JSON.parse(response.body)
            expect(response_object["error"]).to_not eq nil
        end

        it "should not allow users to accept invites from a nonexistent user" do
            Invite.stub(:pending_invite).and_return(@invite)
            User.stub(:find_by_id).and_return(nil)
            post "accept", :from_user => 2
            response_object = JSON.parse(response.body)
            expect(response_object["error"]).to_not eq nil
        end

        it "should allow users to accept invites" do
            Invite.stub(:pending_invite).and_return(@invite)
            User.stub(:find_by_id).and_return(@other)
            expect(@invite).to receive(:accept).once
            post "accept", :from_user => 2
            response_object = JSON.parse(response.body)
            expect(response_object["success"]).to_not eq nil
        end
    end

    context "#reject" do
        before :each do
            @me = double "the user", :present? => true, :id => 1
            @other = double "another user", :present? => true, :id => 2
            @token_results = { :user => @me }
            controller.instance_variable_set(:@token_results, @token_results)
            controller.stub(:check_access_token).and_return(true)
            @invite = double "invite", :accept => true
        end

        it "should allow users to reject invites" do
            Invite.stub(:pending_invite).and_return(@invite)
            User.stub(:find_by_id).and_return(@other)
            expect(@invite).to receive(:reject).once
            post "reject", :from_user => 2
            response_object = JSON.parse(response.body)
            expect(response_object["success"]).to_not eq nil
        end
    end
end
