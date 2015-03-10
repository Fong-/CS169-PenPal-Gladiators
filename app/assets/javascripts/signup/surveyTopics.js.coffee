surveyTopics = angular.module("SurveyTopics", [])

surveyTopics.config(($routeProvider) ->
    $routeProvider.when("/topics", {
        templateUrl: "/assets/survey_topics.html",
        controller: "SurveyTopicsController"
    })

).controller("SurveyTopicsController", ($scope, $http, $location, $routeParams) ->
    $scope.MIN_NUM_TOPICS_REQUIRED = 5
    $scope.topics = []
    $scope.topicCheckModel = {}
    # Returns the number of remaining topics the user needs to fill out.
    numSelectedTopics = -> ($scope.topicCheckModel[key] for key of $scope.topicCheckModel).reduce(((s, t) -> s + t), 0)
    numTopicsRemaining = -> Math.max(0, $scope.MIN_NUM_TOPICS_REQUIRED - numSelectedTopics())
    mock_load_topics = (callback) ->
        # TODO Replace with a request to the server.
        setTimeout( ->
            topics = [{id: 0, icon: "/assets/topic_icons/climate.png", name: "Climate"}, {id: 1, icon: "/assets/topic_icons/education.png", name: "Education"}, {id: 2, icon: "/assets/topic_icons/money.png", name: "Economy"}, {id: 3, icon: "/assets/topic_icons/technology.png", name: "Technology"}, {id: 4, icon: "/assets/topic_icons/lgbt.png", name: "LGBT Rights"}, {id: 5, icon: "/assets/topic_icons/immigration.png", name: "Immigration Law"}, {id: 6, icon: "/assets/topic_icons/international.png", name: "Foreign Policy"}, {id: 7, icon: "/assets/topic_icons/religion.png", name: "Religion"}, {id: 8, icon: "/assets/topic_icons/philosophy.png", name: "Philosophy"}, {id: 10, icon: "/assets/topic_icons/justice.png", name: "Criminal Law"}]
            callback(topics)
        , 250)

    # Computes the value of the next button.
    $scope.nextButtonValue = -> if numTopicsRemaining() == 0 then "Continue to Survey Questions" else "#{numTopicsRemaining()} More Topic#{if numTopicsRemaining() == 1 then '' else 's'} to Continue"

    # Computes whether or not the next button should be disabled.
    $scope.disableNextButton = -> numTopicsRemaining() > 0

    # Called when a topic is selected.
    $scope.handleTopicSelected = (topicId) -> $scope.topicCheckModel[topicId] = not $scope.topicCheckModel[topicId]

    # Advances to the next view.
    $scope.handleAdvanceToQuestions = -> $location.path("questions").search("topic", id for id of $scope.topicCheckModel when $scope.topicCheckModel[id])

    # Asynchronously load the list of topics.
    mock_load_topics (topics) ->
        $scope.topics = topics.sort((u, v) -> u.id - v.id)
        $scope.topicCheckModel[id] = true for id in $routeParams["topic"] if "topic" of $routeParams
        $scope.$apply()
)
