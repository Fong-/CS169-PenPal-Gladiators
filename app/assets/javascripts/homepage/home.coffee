home = angular.module("Home", ["SharedServices"])

home.controller("HomeController", ["$scope", "API", ($scope, API) ->
    $scope.conversations = []
    $scope.shouldDisplayNoConversationsMessage = -> hasLoadedConversations and $scope.conversations.length  == 0
    hasLoadedConversations = false
    updateConversations = ->
        API.recentConversationsWithResolutions().success (response) ->
            $scope.conversations = response.conversations
    updateConversations()
])
