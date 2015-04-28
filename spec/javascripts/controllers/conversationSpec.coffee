#= require ./spec_helper

describe "ConversationController", ->
    beforeEach ->
        @http.when("GET", "/api/v1/conversation/1").respond {
            "id": 1,
            "title": "Why is the US education system terrible?",
            "posts": [
                {
                    "id": 3,
                    "author": {
                        "username": "SnowySun",
                        "avatar": null,
                        "id": 1
                    },
                    "post_type": "post",
                    "text": "Hello world (third post)",
                    "timestamp": "2015-04-12T18:48:52Z"
                },
                {
                    "id": 2,
                    "author": {
                        "username": "MuddyTree",
                        "avatar": null,
                        "id": 3
                    },
                    "post_type": "post",
                    "text": "Hello world (second post)",
                    "timestamp": "2015-04-12T18:48:52Z"
                },
                {
                    "id": 1,
                    "author": {
                        "username": "SnowySun",
                        "avatar": null,
                        "id": 1
                    },
                    "post_type": "post",
                    "text": "Hello world (first post)",
                    "timestamp": "2015-04-12T18:48:52Z"
                }
            ],
            "summaries": [
                {
                    "author": {
                        "username": "MuddyTree",
                        "avatar": null,
                        "id": 3
                    },
                    "text": "I am summarizing your views."
                },
                {
                    "author": {
                        "username": "SnowySun",
                        "avatar": null,
                        "id": 1
                    },
                    "text": ""
                }
            ],
        }
        @http.expectGET("/api/v1/conversation/1")
        @controller("ConversationController", {
            $scope: @scope,
            $stateParams: {id: 1},
            AppState: {user: {id: 1}}
        })
        @http.flush()

    it "should have the correct title and posts", ->
        expect(@scope.title()).toEqual "Why is the US education system terrible?"
        expect(@scope.posts.length).toEqual 3
        expect(@scope.posts[2].text).toEqual "Hello world (third post)"
        expect(@scope.posts[1].text).toEqual "Hello world (second post)"
        expect(@scope.posts[0].text).toEqual "Hello world (first post)"

    it "should allow the user to toggle the post editor", ->
        expect(@scope.shouldHidePostEditor()).toEqual true
        expect(@scope.postLengthClass()).toEqual "posts-full-length"
        @scope.addPostClicked()
        expect(@scope.shouldDisableAddPost()).toEqual true
        expect(@scope.shouldHidePostEditor()).toEqual false
        expect(@scope.postLengthClass()).toEqual "posts-shortened"
        @scope.cancelPostClicked()
        expect(@scope.shouldHidePostEditor()).toEqual true
        expect(@scope.postLengthClass()).toEqual "posts-full-length"
        expect(@scope.shouldDisableAddPost()).toEqual false

    it "should not allow the user to make an empty post", ->
        @scope.addPostClicked()
        expect(@scope.shouldDisableSubmitPost()).toEqual true
        @scope.editPostText = "Hello world"
        expect(@scope.shouldDisableSubmitPost()).toEqual false

    it "should load post text when editing", ->
        @scope.editPostClicked(1)
        expect(@scope.editPostText).toEqual "Hello world (first post)"

    it "should clear edit post text when making a new post", ->
        @scope.editPostClicked(1)
        @scope.cancelPostClicked()
        @scope.addPostClicked()
        expect(@scope.editPostText).toEqual ""

    it "should only display an edit link for the user's own posts", ->
        expect(@scope.shouldDisplayPostEdit(1)).toEqual true
        expect(@scope.shouldDisplayPostEdit(2)).toEqual false
        expect(@scope.shouldDisplayPostEdit(3)).toEqual true

    it "should be able to submit a new post", ->
        @http.expectPOST("/api/v1/post/create/1").respond { "success": "Successfully saved post!" }
        @scope.addPostClicked()
        @scope.editPostText = "Hello world (fourth post)"
        @scope.submitPostClicked()
        @http.flush()
        expect(@scope.shouldHidePostEditor()).toEqual true

    it "should allow the user to edit an existing post", ->
        @http.expectPOST("/api/v1/post/edit/1").respond { "success": "Successfully saved post!" }
        @scope.editPostClicked(1)
        @scope.editPostText = "Hello world (1st post)"
        @scope.submitPostClicked()
        @http.flush()
        expect(@scope.shouldHidePostEditor()).toEqual true

    it "should show the correct opponent and summaries", ->
        expect(@scope.opponentDisplayName()).toEqual "MuddyTree"
        expect(@scope.ownPendingSummaryText()).toEqual "I am summarizing your views."
        expect(@scope.ownPendingSummaryExists()).toEqual true

    it "should allow the user to edit the opposing summary", ->
        @http.expectPOST("/api/v1/conversation/edit_summary/1").respond { "success": true }
        @scope.proposeSummaryClicked()
        @scope.editPostText = "Hello world!"
        @scope.submitPostClicked()
        @http.flush()
        expect(@scope.editPostText).toEqual "Hello world!"

    it "should allow the user to approve a pending summary of his/her viewpoint", ->
        @http.expectPOST("/api/v1/conversation/approve_summary/1").respond { "success": true }
        @scope.proposeSummaryClicked()
        @scope.approveSummaryClicked()
        @http.flush()
        expect(@scope.editPostText).toEqual ""
