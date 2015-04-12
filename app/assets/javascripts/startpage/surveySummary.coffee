surveySummary = angular.module("SurveySummary", ["StartPageServices"])

surveySummary.config(["$routeProvider", ($routeProvider) ->
    $routeProvider
    .when("/summary", {
        templateUrl: "/assets/survey_summary.html",
        controller: "SurveySummaryController"
    })
])

surveySummary.controller("SurveySummaryController", ["$scope", "$http", "$location", "StartPageStaticData", "StartPageStateData" ($scope, $http, $location, StartPageStaticData, StartPageStateData) ->
    allTopics = StartPageStaticData.topics
    $scope.selectedTopics = {}
    for topicId in StartPageStateData.selectedTopics
        $scope.selectedTopics[topicId] = allTopics[topicId]

    # The summary text for each responses chosen by the user, grouped by topic id
    $scope.responseTexts = {}
    for _id, topic of $scope.selectedTopics
        questions = StartPageStaticData.getQuestionsForTopic(topic.id)
        responseIds = StartPageStateData.getResponsesForTopic(topic.id)
        $scope.responseTexts[topic.id] = ""
        for question in questions
            for response in question.survey_responses
                if responseIds[response.id]
                    $scope.responseTexts[topic.id] += response.summary_text + " "

    # Move to the edit page for questions of a topic
    $scope.editResponses = (topicId) ->
        $location.path("questions/#{topicId}")

    # Register the user into the database and move to the homepage
    $scope.handleRegister = ->
        # TODO
        return
])
