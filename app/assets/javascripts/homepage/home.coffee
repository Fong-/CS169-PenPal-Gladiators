home = angular.module("Home", ["SharedServices"])

home.controller("HomeController", ["$scope", "API", ($scope, API) ->
    # Lower indices are to the left. Higher indices correspond to right columns.
    $scope.conversations = [[], []]
    conversationLengths = [0, 0]
    approximateConversationLength = (conversation) -> (conversation.title + conversation.resolution).split(/\s+/).length
    $scope.shouldDisplayNoConversationsMessage = -> hasLoadedConversations and $scope.conversations[0].length + $scope.conversations[1].length == 0
    hasLoadedConversations = false
    updateConversations = ->
        API.recentConversationsWithResolutions().success (response) ->
            $scope.conversations = [[], []]
            conversationLengths = [0, 0]
            for conversation in response.conversations
                conversationLength = approximateConversationLength(conversation)
                if conversationLengths[0] <= conversationLengths[1]
                    $scope.conversations[0].push conversation
                    conversationLengths[0] += conversationLength
                else
                    $scope.conversations[1].push conversation
                    conversationLengths[1] += conversationLength
            hasLoadedConversations = true
    updateConversations()
])
