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
end
