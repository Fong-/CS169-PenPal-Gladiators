home = angular.module("Home", ["SharedServices"])

home.controller("HomeController", ["$scope", "API", ($scope, API) ->
    # Lower indices are to the left. Higher indices correspond to right columns.
    $scope.conversations = [[], []]
    conversationLengths = [0, 0]
    openedConversationId = null
    $scope.openedConversationPosts = []
    conversationHasLoaded = false
    conversationsById = {}
    approximateConversationLength = (conversation) -> (conversation.title + conversation.resolution).split(/\s+/).length
    $scope.shouldDisplayNoConversationsMessage = -> hasLoadedConversations and $scope.conversations[0].length + $scope.conversations[1].length == 0
    hasLoadedConversations = false
    updateConversations = ->
        API.recentConversationsWithResolutions().success (response) ->
            $scope.conversations = [[], []]
            conversationLengths = [0, 0]
            for conversation in response.conversations
                conversationsById[conversation.id] = conversation
                conversationLength = approximateConversationLength(conversation)
                if conversationLengths[0] <= conversationLengths[1]
                    $scope.conversations[0].push conversation
                    conversationLengths[0] += conversationLength
                else
                    $scope.conversations[1].push conversation
                    conversationLengths[1] += conversationLength
            hasLoadedConversations = true
    updateConversations()

    $scope.shouldDisplayConversationPopup = -> openedConversationId?
    $scope.newsfeedHeadingOpacityClass = -> if $scope.shouldDisplayConversationPopup() then "background-opacity" else "foreground-opacity"
    $scope.conversationPopupClass = -> if $scope.shouldDisplayConversationPopup() then "conversation-container-background" else "conversation-container-foreground"
    $scope.conversationClicked = (id) ->
        if openedConversationId?
            openedConversationId = null
            return
        openedConversationId = id
        conversationHasLoaded = false
        API.publicConversationContentById(openedConversationId).success (response) ->
            $scope.openedConversationPosts = response.posts
            conversationHasLoaded = true

    $scope.closeConversationPopup = ->
        if !conversationHasLoaded then return
        openedConversationId = null
        $scope.openedConversationPosts = []

    $scope.homeScrollableClass = -> if $scope.shouldDisplayConversationPopup() then "vertical-scroll-disabled" else "vertical-scroll-enabled"
    $scope.popupConversationTitle = -> if openedConversationId of conversationsById then conversationsById[openedConversationId].title else ""
])
