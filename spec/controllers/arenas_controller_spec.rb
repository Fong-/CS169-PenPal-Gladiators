require "spec_helper"
require "json"

describe ArenasController do
    context "#get_by_user_id" do
        before :each do
            @arena = double "Arena Instance", :response_object => { :a => 1 }
            user = double "User", :arenas => [@arena] * 5
            User.stub(:find).and_return(user)
        end

        it "should construct responses for each arena object" do
            expect(@arena).to receive(:response_object).exactly(5).times
            get "get_by_user_id", :user_id => 1
        end

        it "should return the result" do
            get "get_by_user_id", :user_id => 1
            response_object = JSON.parse(response.body)
            response_object.each { |arena| expect(arena["a"]).to eq(1) }
        end
    end
end
