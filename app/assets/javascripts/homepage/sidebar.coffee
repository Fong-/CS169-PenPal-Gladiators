sidebar = angular.module("Sidebar", ["SharedServices"])

sidebar.controller("SidebarController", ["$scope", "$http", "$state", "API", "TimeUtil", "AppState", ($scope, $http, $state, API, TimeUtil, AppState) ->

    MAX_PREVIEW_TEXT_LENGTH = 100;
    authorTextForId = (id) -> if id == currentUserId then "You" else $scope.gladiatorById[id].username
    previewTextFromPost = (text) -> if text.length > MAX_PREVIEW_TEXT_LENGTH then text.substr(0, MAX_PREVIEW_TEXT_LENGTH) + "..." else text
    postPreviewTextForConversation = (conversation) ->
        if conversation.recent_post
            "#{authorTextForId(conversation.recent_post.author_id)} said: \"#{previewTextFromPost(conversation.recent_post.text)}\""
        else
            "Looks like no one has made any posts. Be the first to write something!"
    currentUserId = AppState.user.id

    $scope.conversationsByUserId = {}
    $scope.gladiatorIds = []
    $scope.gladiatorById = {}
    $scope.arenaStateByUserId = {}
    $scope.toggleGladiatorPanel = (id) -> $scope.arenaStateByUserId[id] = !$scope.arenaStateByUserId[id]
    $scope.expandButtonClass = (id) -> if $scope.arenaStateByUserId[id] then "glyphicon glyphicon-chevron-up" else "glyphicon glyphicon-chevron-down"
    $scope.conversationPreviewClicked = (id) -> $state.go("conversation", { id: id })

    $scope.conversationStartClicked = (id) ->
        API.createConversationByUser(id)
            .success (conversation) ->
                $state.go("conversation", { id: conversation.id })
                reloadSidebarArenas()
            .error (result, status) ->
                if result?
                    reason = result.error
                else
                    reason = "status code #{status}"
                console.log "sidebar failed: #{reason}"

    reloadSidebarArenas = () ->
        API.requestArenasByUser(currentUserId)
            .success (arenas) ->
                $scope.conversationsByUserId = {}
                $scope.gladiatorIds = []
                for arena in arenas
                    $scope.gladiatorById[arena.user1.id] = arena.user1
                    $scope.gladiatorById[arena.user2.id] = arena.user2
                    otherGladiatorId = if currentUserId is arena.user1.id then arena.user2.id else arena.user1.id
                    $scope.conversationsByUserId[otherGladiatorId] = []
                    for conversation in arena.conversations
                        secondsSinceUpdateTime = TimeUtil.timeSince1970InSeconds() - TimeUtil.timeFromTimestampInSeconds(conversation.timestamp)
                        conversationPreviewData = {
                            id: conversation.id,
                            title: conversation.title,
                            time: TimeUtil.timeIntervalAsString(secondsSinceUpdateTime) + " ago",
                            post_preview_text: postPreviewTextForConversation(conversation)
                        }
                        $scope.conversationsByUserId[otherGladiatorId].push(conversationPreviewData)
                    $scope.arenaStateByUserId[otherGladiatorId] = false if otherGladiatorId not of $scope.arenaStateByUserId
                    $scope.gladiatorIds.push(otherGladiatorId)
            .error (result, status) ->
                if result?
                    reason = result.error
                else
                    reason = "status code #{status}"
                console.log "sidebar failed: #{reason}"

    reloadSidebarArenas()
])
