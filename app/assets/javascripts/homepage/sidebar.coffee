sidebar = angular.module("Sidebar", ["SharedServices"])

sidebar.directive("requestsPopover", ["$compile", "$templateCache", ($compile, $templateCache) ->
    template = "<li ng-repeat='matchedGladiator in matchedGladiators'>{{ matchedGladiator }}</li>"
    getTemplate = () -> $templateCache.get("requests_content.html")
    html = getTemplate()

    obj =
        restrict: "A"
        transclude: true
        template: "<span ng-transclude></span>"
        link: (scope, element, attrs) ->
            popOverContent = $compile(template)(scope)
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

    $scope.testvar = "nothing"
    $scope.change = () ->
        $scope.testvar = "something!"

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
    $scope.singleModel = 0
    $scope.isSentEmpty = false
    $scope.isReceivedEmpty = false
    $scope.request_flag = true

    SIDEBAR_POLL_PERIOD = 10000

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

    # Only call the API on button toggle
    $scope.request_matches_check = () ->
        if $scope.request_flag then $scope.request_matches()
        $scope.request_flag = !$scope.request_flag

    # Request matches from the matching algorithm
    # Assume that the API gives us an 'id' and 'username'
    # This should be triggered by a button press in the view
    $scope.request_matches = () ->
        # Stubbed API call, fix indentation of for loop when un-stubbing
        #API.requestMatches(currentUserId).success (matches) ->
        matches = [
            {id:1, username:"Bob the Buffoon"},
            {id:2, username:"William the Weasel"},
            {id:3, username:"Larry the Llama"},
            {id:4, username:"Olga the Ostrich"},
            {id:5, username:"Anton the Armadillo"},
        ]
        $scope.usersMatching = matches.length
        ###
        for match in matches
            $scope.matchedGladiators[match.id] = match.username
            at_least_one_match = true
        ###
        $scope.matchedGladiators = matches
        at_least_one_match = true

    # Request to be matched with another Gladiator
    # Assume that the API gives us an 'id' and 'username'
    # This should be triggered by a button press in the view
    $scope.request_match = (otherUserId) ->
        # Stubbed API call
#        API.requestMatch(otherUserId).success (request) ->
#            $scope.outboundRequests.push(request)
        $scope.outboundRequests.push({id:otherUserId, inviteStatus: "Pending"})

    # Accept a match request
    # This should be triggered by a button press in the view
    $scope.accept_match = (otherUserId) ->
#        Stubbed API call
#        API.acceptMatch(otherUserId).success (accept) ->
#            # Remove the user from inboundRequests
#            inboundRequests = (x for x in array when x.id != otherUserId))
        $scope.toggleHideReceived(otherUserId)

    # Decline a match request
    # This should be triggered by a button press in the view
    $scope.decline_match = (otherUserId) ->
#        Stubbed API call, fix indentation when un-stubbing
#        API.declineMatch(otherUserId).success (decline) ->
#            # Remove the user from inboundRequests
#            inboundRequests = (x for x in array when x.id != otherUserId))
        $scope.toggleHideReceived(otherUserId)

    # Query the server for new inbound matching requests
    # Assume that the API gives us objects with an 'id' and 'username'
    # This is called automatically in setInterval
    $scope.inbound_requests = () ->
#        Stubbed API call, fix indentation of for loop when un-stubbing
#        API.inboundRequests().success (requests) ->
#            for key, request in requests
#                $scope.inboundRequests.push(request)
        requests = [
            {id:23, username:"Jack the Jeckyll"},
            {id:42, username:"Ralph the Reptile"},
            {id:18, username:"Kate the Kangaroo"}
        ]
        $scope.inboundRequests = requests
        $scope.usersInbound = requests.length

    # Query the server for new responses to requests that were sent out before
    # Assume that the API gives us objects with an 'id', 'username', and 'inviteStatus' of request
    # This is called automatically in setInterval
    $scope.outbound_requests = () ->
#        Stubbed API call, fix indentation of for loop when un-stubbing
#        API.outboundRequests().success (requests) ->
#            for key, request in requests
#                $scope.inboundRequests.push(request)
        requests = [
            {id:27, username:"Charlie the Cheetah", status:"Accepted"},
            {id:49, username:"Dolph the Dingo", status:"Accepted"},
            {id:11, username:"Edward the Eel", status:"Accepted"},
            {id:16, username:"Henry the Hippo", status:"Declined"}
        ]
        $scope.outboundRequests = requests
        $scope.usersOutbound = requests.length
        for request in requests
            status = request.status
            switch status
                when "Accepted" then $scope.requestStatusById[request.id] = true
                when "Declined" then $scope.requestStatusById[request.id] = true
                else $scope.requestStatusById[request.id] = false

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
