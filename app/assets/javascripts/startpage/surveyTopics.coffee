surveyTopics = angular.module("SurveyTopics", ["SharedServices", "StartPageServices"])

surveyTopics.controller("SurveyTopicsController", ["$scope", "$http", "$state", "API", "StartPageStaticData", "StartPageStateData", ($scope, $http, $state, API, StartPageStaticData, StartPageStateData) ->
    $scope.MIN_NUM_TOPICS_REQUIRED = 5
    $scope.allTopics = []
    $scope.topicSelectionModel = {}

    currentState = StartPageStateData.currentState
    if currentState == ""
        currentState = "topics"

    # Get the description for the page
    $scope.pageDescription = ->
        if currentState != "topics"
            res =  "Edit selections and press Next to continue."
        else
            res = "Pick at least #{$scope.MIN_NUM_TOPICS_REQUIRED} topics."
        return res + " You may change or add topics later through 'settings.'"

    numSelectedTopics = -> ($scope.topicSelectionModel[id] for id of $scope.topicSelectionModel).reduce(((s, t) -> s + t), 0)
    numTopicsRemaining = -> Math.max(0, $scope.MIN_NUM_TOPICS_REQUIRED - numSelectedTopics())
    # Computes the value of the next button.
    $scope.nextButtonValue = -> if numTopicsRemaining() == 0 then "Continue to Survey Questions" else "#{numTopicsRemaining()} More Topic#{if numTopicsRemaining() == 1 then '' else 's'} to Continue"

    # Computes whether or not the next button should be disabled.
    $scope.disableNextButton = -> numTopicsRemaining() > 0

    # Called when a topic is toggled.
    $scope.handleTopicToggled = (topicId) -> $scope.topicSelectionModel[topicId] = !$scope.topicSelectionModel[topicId]

    # Advances to the next view.
    $scope.handleAdvanceToQuestions = ->
        if currentState == "topics"
            StartPageStateData.currentState = "questions-0"
        StartPageStateData.clearSelectedTopics()
        StartPageStateData.selectTopic(id) for id of $scope.topicSelectionModel when $scope.topicSelectionModel[id]
        sortedTopicIds = Object.keys($scope.topicSelectionModel).sort()
        $state.go("questions", { id: sortedTopicIds[0] })

    # Asynchronously load the list of topics.
    # TODO Cache the results, so we only rerun the query if necessary.
    API.requestTopics()
        .success (allTopics) ->
            StartPageStaticData.clearTopics()
            StartPageStaticData.addTopic(topic) for topic in allTopics
            $scope.allTopics = allTopics.sort((u, v) -> u.id - v.id)
            $scope.topicSelectionModel[id] = true for id in StartPageStateData.selectedTopics
        .error (result, status) ->
            if result?
                reason = result.error
            else
                reason = "status code #{status}"
            console.log "topic request failed: #{reason}"
])
