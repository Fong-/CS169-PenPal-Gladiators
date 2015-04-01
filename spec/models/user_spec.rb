require 'spec_helper'

describe User do
    context "when created without a username" do
        it "should have a generated username" do
            UsernameGenerator.stub(:new).and_return("RandomName")
            expect(User.new.username).to eq("RandomName")
        end
    end

    context "when created without a secret" do
        it "should have a generated secret" do
            SecureRandom.stub(:base64).and_return("1234")
            expect(User.new.secret).to eq("1234")
        end
    end
end
