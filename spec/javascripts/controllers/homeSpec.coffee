#= require ./spec_helper

describe "HomeController", ->
    beforeEach inject (AppState) ->
        @http.when("GET", "/api/v1/conversations/recent_with_resolutions").respond {
            conversations: [
                {
                    id: 1,
                    title: "This is the title of the first conversation.",
                    resolution: "This is a tiny resolution."
                },
                {
                    id: 2,
                    title: "And this is the second conversation.",
                    resolution: "LET us go then, you and I,/ When the evening is spread out against the sky/ Like a patient etherized upon a table;/ Let us go, through certain half-deserted streets,/ The muttering retreats/ Of restless nights in one-night cheap hotels/ And sawdust restaurants with oyster-shells:/ Streets that follow like a tedious argument/ Of insidious intent/ To lead you to an overwhelming question.../ Oh, do not ask, 'What is it?'/ Let us go and make our visit."
                },
                {
                    id: 3,
                    title: "This is the third and final conversation.",
                    resolution: "This is another relatively small resolution."
                }
            ]
        }
        @http.expectGET("/api/v1/conversations/recent_with_resolutions")
        @controller("HomeController", { $scope: @scope })
        @http.flush();

    it "should layout conversations appropriately", ->
        expect(@scope.conversations[0].length + @scope.conversations[1].length).toEqual 3
        if @scope.conversations[0].length > @scope.conversations[1].length
            minConversations = @scope.conversations[1]
            maxConversations = @scope.conversations[0]
        else
            minConversations = @scope.conversations[0]
            maxConversations = @scope.conversations[1]
        expect(minConversations.length).toEqual 1
        expect(maxConversations.length).toEqual 2
        expect(maxConversations[0].title).toEqual "This is the title of the first conversation."
        expect(maxConversations[1].title).toEqual "This is the third and final conversation."
        expect(minConversations[0].title).toEqual "And this is the second conversation."

    it "should show post content when opening a conversation", ->
        post1 = { "name": "The first gladiator", "text": "Foo bar baz." }
        post2 = { "name": "The second gladiator", "text": "This is a tiny resolution." }
        @http.when("GET", "/api/v1/conversation/public/1").respond {
            title: "This is the title of the first conversation.",
            posts: [post1, post2]
        }
        @http.expectGET("/api/v1/conversation/public/1")
        @scope.conversationClicked 1
        @http.flush()
        expect(@scope.openedConversationPosts.length).toEqual 2
        expect(@scope.openedConversationPosts[0]).toEqual post1
        expect(@scope.openedConversationPosts[1]).toEqual post2
        expect(@scope.shouldDisplayConversationPopup()).toEqual true
        @scope.closeConversationPopup()
        expect(@scope.shouldDisplayConversationPopup()).toEqual false
        expect(@scope.openedConversationPosts.length).toEqual 0
