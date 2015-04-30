sidebar = angular.module("Sidebar", ["SharedServices"])

sidebar.controller("SidebarController", ["$scope", "$rootScope", "$state", "API", "TimeUtil", "AppState", ($scope, $rootScope, $state, API, TimeUtil, AppState, SidebarService) ->
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
    $scope.conversationPreviewClicked = (id) ->
        $rootScope.$broadcast "conversationPageWillLoad", { conversationId: id }
        $state.go("conversation", { id: id })

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

    $scope.goToProfile = (id) ->
        $state.go("profile", { id: id })

    reloadSidebarArenas()

    # Register events to trigger sidebar reloading
    $rootScope.$on("reloadSidebarArenas", reloadSidebarArenas)

    # Refresh the sidebar every few seconds
    SIDEBAR_REFRESH_RATE = 5000
    setInterval(() ->
        $rootScope.$broadcast("reloadSidebarArenas")
        $rootScope.$broadcast("reloadSidebarNotifications")
    , SIDEBAR_REFRESH_RATE)
])

sidebar.controller("SidebarMatchesController", ["$scope", "$rootScope", "$state", "API", ($scope, $rootScope, $state, API) ->
    # Toggling different views
    notExpandedClasses = ["glyphicon", "glyphicon-chevron-down"]
    expandedClasses = ["glyphicon", "glyphicon-chevron-up"]

    $scope.expanded = { "pending": false, "matches": false, "incoming": false }
    $scope.classes = { "pending": notExpandedClasses, "matches": notExpandedClasses, "incoming": notExpandedClasses }

    $scope.toggle = (which) ->
        $scope.expanded[which] = !$scope.expanded[which]
        if $scope.expanded[which]
            $scope.classes[which] = expandedClasses
        else
            $scope.classes[which] = notExpandedClasses

    # Controls for handling matches and match invitations
    $scope.matchWith = (id) ->
        API.sendInvite(id)
            .success (result) ->
                reloadSidebarMatches()
                reloadSidebarNotifications()
            .error (result, status) ->
                if result?
                    reason = result.error
                else
                    reason = "status code #{status}"
                console.log "sidebar failed: #{reason}"

        reloadSidebarMatches()
        reloadSidebarNotifications()

    $scope.goToProfile = (id) ->
        $state.go("profile", { id: id })

    $scope.accept = (id) ->
        API.acceptInvite(id)
            .success (invites) ->
                reloadSidebarNotifications()
                $rootScope.$broadcast("reloadSidebarArenas")
            .error (result, status) ->
                if result?
                    reason = result.error
                else
                    reason = "status code #{status}"
                console.log "sidebar failed: #{reason}"

    $scope.reject = (id) ->
        API.rejectInvite(id)
            .success (invites) ->
                reloadSidebarNotifications()
            .error (result, status) ->
                if result?
                    reason = result.error
                else
                    reason = "status code #{status}"
                console.log "sidebar failed: #{reason}"

    # Helpers to refresh and store matches and invites
    $scope.matches = []
    $scope.pending = []
    $scope.incoming = []

    $scope.showPending = () -> $scope.pending.length > 0
    $scope.showIncoming = () -> $scope.incoming.length > 0

    reloadSidebarMatches = () ->
        API.matches()
            .success (matches) ->
                $scope.matches = matches
            .error (result, status) ->
                if result?
                    reason = result.error
                else
                    reason = "status code #{status}"
                console.log "sidebar failed: #{reason}"

    reloadSidebarNotifications = () ->
        API.outgoingInvites()
            .success (invites) ->
                $scope.pending = invites.outgoing
            .error (result, status) ->
                if result?
                    reason = result.error
                else
                    reason = "status code #{status}"
                console.log "sidebar failed: #{reason}"

        API.incomingInvites()
            .success (invites) ->
                $scope.incoming = invites.incoming
            .error (result, status) ->
                if result?
                    reason = result.error
                else
                    reason = "status code #{status}"
                console.log "sidebar failed: #{reason}"

    reloadSidebarMatches()
    reloadSidebarNotifications()

    # Register events to trigger sidebar reloading
    $rootScope.$on("reloadSidebarMatches", reloadSidebarMatches)
    $rootScope.$on("reloadSidebarNotifications", reloadSidebarNotifications)
])
