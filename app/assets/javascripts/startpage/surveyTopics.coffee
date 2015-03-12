surveyTopics = angular.module("SurveyTopics", ["StartPageServices"])

surveyTopics.config(($routeProvider) ->
    $routeProvider.when("/topics", {
        templateUrl: "/assets/survey_topics.html",
        controller: "SurveyTopicsController"
    })

).controller("SurveyTopicsController", ($scope, $http, $location, StartPageData) ->
    $scope.MIN_NUM_TOPICS_REQUIRED = 5
    $scope.allTopics = []
    $scope.topicSelectionModel = {}
    # Returns the number of remaining topics the user needs to fill out.
    numSelectedTopics = -> ($scope.topicSelectionModel[id] for id of $scope.topicSelectionModel).reduce(((s, t) -> s + t), 0)
    numTopicsRemaining = -> Math.max(0, $scope.MIN_NUM_TOPICS_REQUIRED - numSelectedTopics())
    mock_load_topics = (callback) ->
        # TODO Replace with a request to the server.
        setTimeout( ->
            callback([{id: 0, icon: "/assets/topic_icons/climate.png", name: "Climate"}, {id: 1, icon: "/assets/topic_icons/education.png", name: "Education"}, {id: 2, icon: "/assets/topic_icons/money.png", name: "Economy"}, {id: 3, icon: "/assets/topic_icons/technology.png", name: "Technology"}, {id: 4, icon: "/assets/topic_icons/lgbt.png", name: "LGBT Rights"}, {id: 5, icon: "/assets/topic_icons/immigration.png", name: "Immigration Law"}, {id: 6, icon: "/assets/topic_icons/international.png", name: "Foreign Policy"}, {id: 7, icon: "/assets/topic_icons/religion.png", name: "Religion"}, {id: 8, icon: "/assets/topic_icons/philosophy.png", name: "Philosophy"}, {id: 10, icon: "/assets/topic_icons/justice.png", name: "Criminal Law"}])
        , 250)

    # Computes the value of the next button.
    $scope.nextButtonValue = -> if numTopicsRemaining() == 0 then "Continue to Survey Questions" else "#{numTopicsRemaining()} More Topic#{if numTopicsRemaining() == 1 then '' else 's'} to Continue"

    # Computes whether or not the next button should be disabled.
    $scope.disableNextButton = -> numTopicsRemaining() > 0

    # Called when a topic is toggled.
    $scope.handleTopicToggled = (topicId) -> $scope.topicSelectionModel[topicId] = !$scope.topicSelectionModel[topicId]

    # Advances to the next view.
    $scope.handleAdvanceToQuestions = ->
        StartPageData.clearTopicIds()
        StartPageData.addTopicId(id) for id of $scope.topicSelectionModel when $scope.topicSelectionModel[id]
        $location.path("questions")

    # Asynchronously load the list of topics.
    mock_load_topics (allTopics) ->
        $scope.allTopics = allTopics.sort((u, v) -> u.id - v.id)
        $scope.topicSelectionModel[id] = true for id in StartPageData.getTopicIds()
        $scope.$apply()
)
