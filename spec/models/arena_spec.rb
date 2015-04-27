require 'spec_helper'

describe Arena do
    context "when accessing the arena" do
        before :each do
            @user1 = User.create! :email => "asdf1@asdf.com", :password => "abcdef"
            @user2 = User.create! :email => "asdf2@asdf.com", :password => "abcdef"
            @arena = Arena.create! :user1 => @user1, :user2 => @user2
        end

        it "should belong to the right users" do
            expect(@arena.user1).to eq(@user1)
            expect(@arena.user2).to eq(@user2)
        end

        it "should be found by the users" do
            expect(@user1.arenas.first).to eq(@arena)
            expect(@user2.arenas.first).to eq(@arena)
        end
    end

    context "when using the Arenas API" do
        before :each do
            @user1 = User.create! :email => "asdf1@asdf.com", :password => "abcdef", :username => "User1"
            @user2 = User.create! :email => "asdf2@asdf.com", :password => "abcdef", :username => "User2"
            @arena = Arena.create! :user1 => @user1, :user2 => @user2
            @conversation = @arena.conversations.create! :title => "I love education, how about you?"
            @user1.posts.create! :text => "Yea, I do!", :conversation => @conversation
            @user2.posts.create! :text => "Great lets consensus", :conversation => @conversation
        end

        it "should generate an appropriate response object" do
            response = @arena.response_object
            expect(response[:user1][:id]).to eq(@user1.id)
            expect(response[:user2][:username]).to eq(@user2.username)
            expect(response[:conversations].length).to eq(1)
            expect(response[:conversations].first[:timestamp]).to eq(@conversation.timestamp)
            expect(response[:conversations].first[:recent_post][:author_id]).to eq(@user2.id)
            expect(response[:conversations].first[:recent_post][:text]).to eq("Great lets consensus")
        end
    end
end
