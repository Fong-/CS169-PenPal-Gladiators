conversation = angular.module("Conversation", ["SharedServices"])

conversation.directive("onEscape", ->
    (scope, element, attributes) ->
        element.bind("keydown keypress", (event) ->
            if event.which == 27
                scope.$apply(-> scope.$eval(attributes.onEscape))
                event.preventDefault()
        )
)

conversation.controller("ConversationController", ["$scope", "$stateParams", "API", "TimeUtil", ($scope, $stateParams, API, TimeUtil) ->
    # Constants
    POST_SUBMISSION_TIMEOUT_PERIOD_MS = 5000
    CONVERSATION_POLL_PERIOD = 60 # seconds
    READING_POSTS = 1
    WRITING_POST = 2 # Editing or adding a new post.
    WRITING_CONSENSUS = 3

    # State variables
    conversationId = parseInt($stateParams["id"])
    currentUserId = 1 # TODO Fetch current user through login service.
    postSubmissionInProgress = false
    conversation = {}
    postsById = {}
    currentPostEditId = null
    postSubmissionTimer = null
    lastUpdateTime = 0
    conversationPageState = READING_POSTS
    # Scope methods and models
    $scope.editPostText = ""
    $scope.postSubmitError = ""
    $scope.timeElapsedMessage = (timestamp) -> TimeUtil.timeIntervalAsString(TimeUtil.timeSince1970InSeconds() - TimeUtil.timeFromTimestampInSeconds(timestamp)) + " ago"
    $scope.shouldHidePostEditor = -> conversationPageState is READING_POSTS
    $scope.postLengthClass = -> if conversationPageState is READING_POSTS then "posts-full-length" else "posts-shortened"
    $scope.addPostClicked = ->
        $scope.postSubmitError = ""
        conversationPageState = WRITING_POST
        $scope.editPostText = "" if currentPostEditId # Clear the editor if the user was previously editing an existing post.
        currentPostEditId = null
        dispatchFocusTextarea()

    $scope.cancelPostClicked = -> conversationPageState = READING_POSTS
    $scope.escapeTextEditor = -> conversationPageState = READING_POSTS
    $scope.submitPostText = -> if postSubmissionInProgress then "Sending..." else "Submit"
    $scope.shouldDisableSubmitPost = -> postSubmissionInProgress or $scope.editPostText == ""
    $scope.shouldDisableEditor = -> postSubmissionInProgress
    $scope.submitPostClicked = ->
        $scope.postSubmitError = ""
        postSubmissionInProgress = true
        if currentPostEditId is null
            API.createPostByConversationId(conversationId, $scope.editPostText).success (response) -> handlePostEditResponse(response, true)
        else
            API.editPostById(currentPostEditId, $scope.editPostText).success (response) -> handlePostEditResponse(response, false)
        postSubmissionTimer = setTimeout(->
            $scope.postSubmitError = "Post submission failed. Please try again later."
            postSubmissionInProgress = false
            $scope.$apply()
        , POST_SUBMISSION_TIMEOUT_PERIOD_MS)

    $scope.shouldDisplayPostEdit = (id) -> postsById[id].author.id == currentUserId
    $scope.editPostClicked = (id) ->
        currentPostEditId = id
        $scope.editPostText = postsById[id].text
        conversationPageState = WRITING_POST
        dispatchFocusTextarea()

    $scope.shouldDisableAddPost = -> conversationPageState is WRITING_POST
    $scope.shouldHideConsensus = -> conversationPageState isnt WRITING_CONSENSUS
    $scope.postEditorWidthClass = -> if conversationPageState isnt WRITING_CONSENSUS then "post-editor-full" else "post-editor-half"
    $scope.shouldDisableProposeConsensus = -> conversationPageState is WRITING_CONSENSUS
    $scope.shouldDisableApproveConsensus = -> true
    $scope.proposeConsensusClicked = ->
        conversationPageState = WRITING_CONSENSUS
        dispatchFocusTextarea()

    dispatchScrollElementToBottom = (elementId) ->
        setTimeout ->
            postsContainer = document.getElementById(elementId)
            postsContainer.scrollTop = postsContainer.scrollHeight if postsContainer

    handlePostEditResponse = (response, scrollToEnd) ->
        clearTimeout(postSubmissionTimer) if postSubmissionTimer
        postSubmissionInProgress = false
        unless "error" of response
            $scope.editPostText = ""
            conversationPageState = READING_POSTS
        currentPostEditId = null
        updateConversationData(scrollToEnd)

    dispatchFocusTextarea = ->
        setTimeout ->
            textareas = document.getElementsByTagName("textarea")
            textareas[0].focus() if textareas.length > 0

    updateConversationData = (scrollToEnd) ->
        API.requestConversationById(conversationId).success (response) ->
            conversation = response
            $scope.posts = if "posts" of conversation then conversation["posts"].reverse() else []
            $scope.title = if "title" of conversation then conversation["title"] else ""
            postsById[post.id] = post for post in $scope.posts
            dispatchScrollElementToBottom("posts-container") if scrollToEnd
            lastUpdateTime = TimeUtil.timeSince1970InSeconds()

    shouldPollConversationData = -> TimeUtil.timeSince1970InSeconds() - lastUpdateTime > CONVERSATION_POLL_PERIOD
    setInterval( ->
        updateConversationData(false) if shouldPollConversationData()
    , CONVERSATION_POLL_PERIOD * 1000)

    updateConversationData(true)
])
