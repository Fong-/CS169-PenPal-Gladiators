conversation = angular.module("Conversation", ["ngRoute", "SharedServices"])

conversation.config(["$routeProvider", ($routeProvider) ->
    $routeProvider.when("/conversation/:id", {
        templateUrl: "/assets/conversation.html",
        controller: "ConversationController"
    })

]).directive("ngEscape", ->
    (scope, element, attributes) ->
        element.bind("keydown keypress", (event) ->
            if event.which == 27
                scope.$apply(-> scope.$eval(attributes.ngEscape))
                event.preventDefault()
        )
).controller("ConversationController", ["$scope", "$http", "$location", "$routeParams", "SharedRequests", "TimeUtil", ($scope, $http, $location, $routeParams, SharedRequests, TimeUtil) ->
    # State variables
    conversationId = parseInt($routeParams["id"])
    currentUserId = 1 # TODO Fetch current user through login service.
    currentlyEditingPost = false
    postSubmissionInProgress = false
    conversation = {}
    postsById = {}
    currentPostEditId = null
    # Scope methods and models
    $scope.editPostText = ""
    $scope.timeElapsedMessage = (timestamp) -> TimeUtil.timeIntervalAsString(TimeUtil.timeSince1970InSeconds() - TimeUtil.timeFromTimestampInSeconds(timestamp)) + " ago"
    $scope.postEditorClass = -> if currentlyEditingPost then "" else "hidden"
    $scope.postLengthClass = -> if currentlyEditingPost then "posts-shortened" else "posts-full-length"
    $scope.addPostClicked = ->
        currentlyEditingPost = true
        $scope.editPostText = "" if currentPostEditId # Clear the editor if the user was previously editing an existing post.
        currentPostEditId = null
        dispatchFocusTextarea()

    $scope.cancelPostClicked = -> currentlyEditingPost = false
    $scope.escapeTextEditor = -> currentlyEditingPost = false
    $scope.submitPostText = -> if postSubmissionInProgress then "Sending..." else "Submit"
    $scope.shouldDisableSubmitPost = -> postSubmissionInProgress or $scope.editPostText == ""
    $scope.shouldDisableEditor = -> postSubmissionInProgress
    $scope.submitPostClicked = ->
        postSubmissionInProgress = true
        if currentPostEditId is null
            SharedRequests.createPostByConversationId(conversationId, $scope.editPostText).success (response) ->
                handlePostEditResponse(response)
                updateConversationData(true)
        else
            SharedRequests.editPostById(currentPostEditId, $scope.editPostText).success (response) ->
                handlePostEditResponse(response)
                updateConversationData(false)

    $scope.shouldDisplayPostEdit = (id) -> postsById[id].author.id == currentUserId

    $scope.editPostClicked = (id) ->
        currentPostEditId = id
        $scope.editPostText = postsById[id].text
        currentlyEditingPost = true
        dispatchFocusTextarea()

    $scope.shouldDisableAddPost = -> currentlyEditingPost

    dispatchScrollElementToBottom = (elementId) ->
        setTimeout ->
            postsContainer = document.getElementById(elementId)
            postsContainer.scrollTop = postsContainer.scrollHeight if postsContainer

    handlePostEditResponse = (response) ->
        postSubmissionInProgress = false
        unless "error" of response
            $scope.editPostText = ""
            currentlyEditingPost = false
        currentPostEditId = null

    dispatchFocusTextarea = ->
        setTimeout ->
            textareas = document.getElementsByTagName("textarea")
            textareas[0].focus() if textareas.length > 0

    updateConversationData = (scrollToEnd) ->
        SharedRequests.requestConversationById(conversationId).success (response) ->
            conversation = response
            $scope.posts = if "posts" of conversation then conversation["posts"].reverse() else []
            $scope.title = if "title" of conversation then conversation["title"] else ""
            for post in $scope.posts
                postsById[post.id] = post
            dispatchScrollElementToBottom("posts-container") if scrollToEnd

    updateConversationData(true)
])
