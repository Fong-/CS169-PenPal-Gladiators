sidebar = angular.module("Sidebar", ["SharedServices"])

sidebar.controller("SidebarController", ["$scope", "$http", "$state", "API", "TimeUtil", "AppState", ($scope, $http, $state, API, TimeUtil, AppState) ->

    MAX_PREVIEW_TEXT_LENGTH = 100;
    authorTextForId = (id) -> if id == currentUserId then "You" else $scope.gladiatorNameById[id]
    previewTextFromPost = (text) -> if text.length > MAX_PREVIEW_TEXT_LENGTH then text.substr(0, MAX_PREVIEW_TEXT_LENGTH) + "..." else text
    postPreviewTextForConversation = (conversation) ->
        if conversation.recent_post
            "#{authorTextForId(conversation.recent_post.author_id)} said: \"#{previewTextFromPost(conversation.recent_post.text)}\""
        else
            "Looks like no one has made any posts. Be the first to write something!"
    currentUserId = AppState.user.id

    $scope.conversationsByUserId = {}
    $scope.gladiatorIds = []
    $scope.gladiatorNameById = {}
    $scope.arenaStateByUserId = {}
    $scope.toggleGladiatorPanel = (id) -> $scope.arenaStateByUserId[id] = !$scope.arenaStateByUserId[id]
    $scope.expandButtonClass = (id) -> if $scope.arenaStateByUserId[id] then "glyphicon glyphicon-chevron-up" else "glyphicon glyphicon-chevron-down"
    $scope.conversationPreviewClicked = (id) -> $state.go("conversation", { id: id })

    API.requestArenasByUser(currentUserId)
        .success (arenas) ->
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

    # Matching
    # TODO: API endpoints and add calls to API service
    $scope.matchedGladiators = {}
    $scope.outboundRequests = {}
    $scope.inboundRequests = {}
    at_least_one_match = false

    # Request matches from the matching algorithm
    $scope.request_matches = () ->
        API.requestMatches(currentUserId).success (matches) ->
            for match in matches
                # Assume (naively) that the API gives us an 'id' and 'username'
                $scope.matchedGladiators[match.id] = match.username
                at_least_one_match = true

    # Request to be matched with another Gladiator
    $scope.request_match = (otherUserId) ->
        API.requestMatch(otherUserId).success (request) ->
            $scope.outboundRequests.push(request)

    # Accept a match request
    $scope.accept_match = (otherUserId) ->
        API.acceptMatch(otherUserId).success (accept) ->
            # Do something?

    # Decline a match request
    $scope.decline_match = (otherUserId) ->
        API.declineMatch(otherUserId).success (decline) ->
            # Do something?

    # Query the server for new inbound matching requests
    $scope.inbound_requests = () ->
        API.inboundRequests().success (requests) ->
            for request in requests
                $scope.inboundRequests[request.id] = request.username

    # Query the server for new responses to requests that were sent out before
    $scope.outbound_requests = () ->
        API.outboundRequests().success (requests) ->
            for request in requests
                $scope.outboundRequests[request.id] = {username: request.username, status: request.status}

    # This is hacky because it calls request_matches, so it's not really necessary to call it again from the view
    # Clean this up later
    $scope.can_match = () ->
        $scope.request_matches
        return at_least_one_match
])
