sidebar = angular.module("Sidebar", ["SharedServices"])

sidebar.directive("requestsPopover", ["$compile", "$templateCache", ($compile, $templateCache) ->
    getTemplate = () -> $templateCache.get("requests_content.html")
    html = getTemplate()
    obj =
        restrict: "A"
        transclude: true
        template: "<span ng-transclude></span>"
        link: (scope, element, attrs) ->
            popOverContent = $compile(html)(scope)
            options =
                html: true
                content:  popOverContent
                placement: "bottom"
            $(element).popover options
    return obj
])

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
    # TODO: API endpoints and add calls to API service, better verbiage
    $scope.matchedGladiators = []
    $scope.outboundRequests = []
    $scope.inboundRequests = []

    $scope.usersMatching = 0
    $scope.usersOutbound = 0
    $scope.usersInbound = 0

    at_least_one_match = false

    $scope.requestStatusById = {}
    $scope.hideUserSent = {}
    $scope.hideUserReceived = {}
    $scope.hideUserRequest = {}
    $scope.singleModel = 0
    $scope.isSentEmpty = false
    $scope.isReceivedEmpty = false
    $scope.request_flag = true

    $scope.sentContainerState = false
    $scope.receivedContainerState = false

    SIDEBAR_POLL_PERIOD = 100000

    # Hides attributes after a button click
    # Checks whether containers should be hidden or not
    $scope.toggleHideSent = (UserId) ->
        $scope.hideUserSent[UserId] = true
        $scope.usersOutbound -= 1
        if $scope.usersOutbound == 0 then $scope.isSentEmpty = true

    $scope.toggleHideReceived = (UserId) ->
        $scope.hideUserReceived[UserId] = true
        $scope.usersInbound -= 1
        if $scope.usersInbound == 0 then $scope.isReceivedEmpty = true

    $scope.toggleHideRequest = (UserId) ->
        $scope.hideUserRequest[UserId] = true

    # Only call the API on button toggle
    $scope.request_matches_check = () ->
        if $scope.request_flag then $scope.request_matches()
        $scope.request_flag = !$scope.request_flag

    $scope.toggleSentContainer = () ->
        $scope.sentContainerState = !$scope.sentContainerState

    $scope.toggleReceivedContainer = () ->
        $scope.receivedContainerState = !$scope.receivedContainerState

    $scope.expandSentButton = () -> if $scope.sentContainerState then "glyphicon glyphicon-chevron-up" else "glyphicon glyphicon-chevron-down"
    $scope.expandReceivedButton = () -> if $scope.receivedContainerState then "glyphicon glyphicon-chevron-up" else "glyphicon glyphicon-chevron-down"

    # Request matches from the matching algorithm
    # Assume that the API gives us an 'id' and 'username'
    # This should be triggered by a button press in the view
    $scope.request_matches = () ->
        console.log("Requesting Matches")
        API.requestMatches(currentUserId)
            .success (matches) ->
                $scope.usersMatching = matches.length
                for match in matches
                    $scope.matchedGladiators.push({id:match.user.id, username:match.user.username})
                    at_least_one_match = true
                $scope.hideUserRequest = {} # reset so everything will be visible again
            .error (result, status) ->
                if result?
                    reason = result.error
                else
                    reason = "status code #{status}"
                console.log "matches loading failed: #{reason}"

    # Request to be matched with another Gladiator
    # This should be triggered by a button press in the view
    $scope.request_match = (otherUserId) ->
        API.requestMatch(currentUserId, otherUserId)
            .success (requestStatus) ->
                $scope.outbound_requests()
            .error (result, status) ->
                if result?
                    reason = result.error
                else
                    reason = "status code #{status}"
                console.log "matching with user failed: #{reason}"

    # Accept a match request
    # This should be triggered by a button press in the view
    $scope.accept_match = (otherUserId) ->
        API.respondToRequest(currentUserId, otherUserId, "accept")
            .success (accept) ->
                # Remove the user from inboundRequests by querying the API
                $scope.inboundRequests()
                $scope.toggleHideReceived(otherUserId)
            .error (result, status) ->
                if result?
                    reason = result.error
                else
                    reason = "status code #{status}"
                console.log "accepting match failed: #{reason}"

    # Decline a match request
    # This should be triggered by a button press in the view
    $scope.decline_match = (otherUserId) ->
        API.respondToRequest(currentUserId, otherUserId, "decline")
            .success (accept) ->
                # Remove the user from inboundRequests by querying the API
                $scope.inboundRequests()
                $scope.toggleHideReceived(otherUserId)
            .error (result, status) ->
                if result?
                    reason = result.error
                else
                    reason = "status code #{status}"
                console.log "declining match failed: #{reason}"

    # Query the server for new inbound matching requests
    # Assume that the API gives us objects with an 'id' and 'username'
    # This is called automatically in setInterval
    $scope.inbound_requests = () ->
        API.incomingRequests(currentUserId)
            .success (requests) ->
                console.log(requests)
                for request in requests
                    $scope.inboundRequests.push({id: request.from_id, username: request.username})
                $scope.usersInbound = requests.length
            .error (result, status) ->
                if result?
                    reason = result.error
                else
                    reason = "status code #{status}"
                console.log "querying inbound requests failed: #{reason}"

    # Query the server for new responses to requests that were sent out before
    # Assume that the API gives us objects with an 'id', 'username', and 'inviteStatus' of request
    # This is called automatically in setInterval
    $scope.outbound_requests = () ->
        API.requestStatus(currentUserId)
            .success (requests) ->
                console.log("Outgoing:", requests)
                for request in requests
                    $scope.outboundRequests.push({id:request.from_id, username:request.username, status:request.status})
                $scope.usersOutbound = requests.length
                for request in requests
                    status = request.status
                    switch status
                        when "Accepted" then $scope.requestStatusById[request.id] = true
                        when "Declined" then $scope.requestStatusById[request.id] = true
                        else $scope.requestStatusById[request.id] = false
            .error (result, status) ->
                if result?
                    reason = result.error
                else
                    reason = "status code #{status}"
                console.log "querying outbound_requests failed: #{reason}"

    # This is hacky because it calls request_matches, so it's not really necessary to call it again from the view
    # Clean this up later
    $scope.can_match = () ->
        $scope.request_matches
        return at_least_one_match

    # Poll the server at a regular interval
    setInterval(() ->
        $scope.outbound_requests()
        $scope.inbound_requests()
    , SIDEBAR_POLL_PERIOD)

    # Get inbound and outbound requests at time of page load
    $scope.outbound_requests()
    $scope.inbound_requests()
])
