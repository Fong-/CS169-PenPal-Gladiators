surveyTopics = angular.module("SurveyTopics", ["SharedServices", "StartPageServices"])

surveyTopics.config(($routeProvider) ->
    $routeProvider.when("/topics", {
        templateUrl: "/assets/survey_topics.html",
        controller: "SurveyTopicsController"
    })

).controller("SurveyTopicsController", ($scope, $http, $location, SharedRequests, StartPageData) ->
    $scope.MIN_NUM_TOPICS_REQUIRED = 5
    $scope.allTopics = []
    $scope.topicSelectionModel = {}

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
        StartPageData.clearSelectedTopicIds()
        StartPageData.addSelectedTopicId(id) for id of $scope.topicSelectionModel when $scope.topicSelectionModel[id]
        sortedTopicIds = Object.keys($scope.topicSelectionModel).sort()
        $location.path("questions/#{sortedTopicIds[0]}")

    # Asynchronously load the list of topics.
    # TODO Cache the results, so we only rerun the query if necessary.
    SharedRequests.requestTopics().success (allTopics) ->
        StartPageData.clearAllTopics()
        StartPageData.addTopic(topic) for topic in allTopics
        $scope.allTopics = allTopics.sort((u, v) -> u.id - v.id)
        $scope.topicSelectionModel[id] = true for id in StartPageData.getSelectedTopicIds()
)
