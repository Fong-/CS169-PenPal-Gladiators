#= require ./spec_helper

describe "HomeController", ->
    beforeEach inject (AppState) ->
        @http.when("GET", "/api/v1/conversations/recent_with_resolutions").respond {
            conversations: [
                {
                    title: "This is the title of the first conversation.",
                    resolution: "This is a tiny resolution."
                },
                {
                    title: "And this is the second conversation.",
                    resolution: "LET us go then, you and I,/ When the evening is spread out against the sky/ Like a patient etherized upon a table;/ Let us go, through certain half-deserted streets,/ The muttering retreats/ Of restless nights in one-night cheap hotels/ And sawdust restaurants with oyster-shells:/ Streets that follow like a tedious argument/ Of insidious intent/ To lead you to an overwhelming question.../ Oh, do not ask, 'What is it?'/ Let us go and make our visit."
                },
                {
                    title: "This is the third and final conversation.",
                    resolution: "This is another relatively small resolution."
                }
            ]
        }
        @http.expectGET("/api/v1/conversations/recent_with_resolutions")
        @controller("HomeController", { $scope: @scope })
        @http.flush();

    it "should layout conversations appropriately", ->
        expect(@scope.conversations.length).toEqual 3
        expect(@scope.conversations[0].title).toEqual "This is the title of the first conversation."
        expect(@scope.conversations[1].title).toEqual "And this is the second conversation."
        expect(@scope.conversations[2].title).toEqual "This is the third and final conversation."