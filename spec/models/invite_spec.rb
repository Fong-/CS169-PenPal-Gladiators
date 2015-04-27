require 'spec_helper'

describe Invite do
    context "managing invitations between users" do
        before :each do
            @user1 = User.create! :email => "asdf1@asdf.com", :password => "abcdef"
            @user2 = User.create! :email => "asdf2@asdf.com", :password => "abcdef"
            @user3 = User.create! :email => "asdf3@asdf.com", :password => "abcdef"
        end

        it "should not allow a user to invite him/herself" do
            expect(Invite.did_create_new_invite @user1, @user1).to eq false
        end

        it "should not allow a user to invite a penpal" do
            Arena.create :user1 => @user1, :user2 => @user2
            expect(Invite.did_create_new_invite @user1, @user2).to eq false
        end

        it "should allow a user to invite another user at most once at a time" do
            expect(Invite.did_create_new_invite @user1, @user2).to eq true
            expect(Invite.pending_invite @user1, @user2).to_not eq nil
            expect(Invite.did_create_new_invite @user1, @user2).to eq false
        end

        it "should destroy the invite and create a new arena upon acceptance" do
            invite = Invite.create :from => @user1, :to => @user2
            invite.accept
            expect(Invite.pending_invite @user1, @user2).to eq nil
            expect(Arena.find_by_user1_id @user1.id).to_not eq nil
        end

        it "should just destroy the invite and upon rejection" do
            invite = Invite.create :from => @user1, :to => @user2
            invite.reject
            expect(Invite.pending_invite @user1, @user2).to eq nil
            expect(Arena.find_by_user1_id @user1.id).to eq nil
        end

        it "should find users invited by a given user" do
            Invite.create :from => @user1, :to => @user2
            Invite.create :from => @user1, :to => @user3
            result = Invite.all_users_invited_by @user1
            expect(result.length).to eq 2
            expect(result.include? @user2).to eq true
            expect(result.include? @user3).to eq true
        end

        it "should find users that have invited a given user" do
            Invite.create :from => @user2, :to => @user1
            Invite.create :from => @user3, :to => @user1
            result = Invite.all_users_inviting @user1
            expect(result.length).to eq 2
            expect(result.include? @user2).to eq true
            expect(result.include? @user3).to eq true
        end
    end
end
