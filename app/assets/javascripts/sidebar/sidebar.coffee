sidebar = angular.module("Sidebar", ["SharedServices"])

sidebar.controller("SidebarController", ["$scope", "$http", "$location", "SharedRequests", "TimeUtil", ($scope, $http, $location, SharedRequests, TimeUtil) ->

    MAX_PREVIEW_TEXT_LENGTH = 100;
    authorTextForId = (id) -> if id == currentUserId then "You" else $scope.gladiatorNameById[id]
    previewTextFromPost = (text) -> if text.length > MAX_PREVIEW_TEXT_LENGTH then text.substr(0, MAX_PREVIEW_TEXT_LENGTH) + "..." else text
    postPreviewTextForConversation = (conversation) ->
        if conversation.recent_post
            "#{authorTextForId(conversation.recent_post.author_id)} said: \"#{previewTextFromPost(conversation.recent_post.text)}\""
        else
            "Looks like no one has made any posts. Be the first to write something!"
    currentUserId = 1 # Change when hooking into authentication route.

    $scope.conversationsByUserId = {}
    $scope.gladiatorIds = []
    $scope.gladiatorNameById = {}
    $scope.arenaStateByUserId = {}
    $scope.toggleGladiatorPanel = (id) -> $scope.arenaStateByUserId[id] = !$scope.arenaStateByUserId[id]
    $scope.expandButtonClass = (id) -> if $scope.arenaStateByUserId[id] then "glyphicon glyphicon-chevron-up" else "glyphicon glyphicon-chevron-down"

    SharedRequests.requestArenasByUser(currentUserId).success (arenas) ->
        $scope.conversationsByUserId = {}
        $scope.gladiatorIds = []
        for arena in arenas
            $scope.gladiatorNameById[arena.user1.id] = arena.user1.name
            $scope.gladiatorNameById[arena.user2.id] = arena.user2.name
            otherGladiatorId = if currentUserId is arena.user1.id then arena.user2.id else arena.user1.id
            $scope.conversationsByUserId[otherGladiatorId] = []
            for conversation in arena.conversations
                secondsSinceUpdateTime = TimeUtil.timeSince1970InSeconds() - TimeUtil.timeFromTimestampInSeconds(conversation.timestamp)
                conversationPreviewData = {
                    title: conversation.title,
                    time: TimeUtil.timeIntervalAsString(secondsSinceUpdateTime) + " ago",
                    post_preview_text: postPreviewTextForConversation(conversation)
                }
                $scope.conversationsByUserId[otherGladiatorId].push(conversationPreviewData)
            $scope.arenaStateByUserId[otherGladiatorId] = false if otherGladiatorId not of $scope.arenaStateByUserId
            $scope.gladiatorIds.push(otherGladiatorId)
])
