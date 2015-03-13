require 'spec_helper'

describe Topic do
    context "when using the topics API" do
        before :each do
            @climate = Topic.create(:name => "Climate", :icon => "/some/path/climate.png")
            @response = @climate.response_object
        end

        it "should contain only id, icon and name fields in its response object" do
            expect(@response[:id]).to equal(@climate.id)
            expect(@response[:icon]).to equal(@climate.icon)
            expect(@response[:name]).to equal(@climate.name)
            expect(@response[:created_at]).to equal(nil)
            expect(@response[:updated_at]).to equal(nil)
        end
    end
end
