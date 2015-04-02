surveySummary = angular.module("SurveySummary", ["StartPageServices"])

surveySummary.config(["$routeProvider", ($routeProvider) ->
    $routeProvider.when("/summary", {
        templateUrl: "/assets/survey_summary.html",
        controller: "SurveySummaryController"
    })
]).controller("SurveySummaryController", ["$scope", "$http", "$location", "SharedRequests", "StartPageData", ($scope, $http, $location, SharedRequests, StartPageData) ->
    allTopics = StartPageData.getAllTopics()
    $scope.selectedTopics = {}
    for topicId in StartPageData.getSelectedTopicIds()
        $scope.selectedTopics[topicId] = allTopics[topicId]

    # The summary text for each responses chosen by the user, grouped by topic id
    $scope.responseTexts = {}
    for _id, topic of $scope.selectedTopics
        questions = StartPageData.getTopicQuestions(topic.id)
        responseIds = StartPageData.getResponseIdsByTopicId(topic.id)
        $scope.responseTexts[topic.id] = ""
        console.log(responseIds)
        for question in questions
            for response in question.survey_responses
                if responseIds[response.id]
                    console.log(response)
                    $scope.responseTexts[topic.id] += response.summary_text + " "

    # Move to the edit page for questions of a topic
    $scope.editResponses = (topicId) ->
        $location.path("questions/#{topicId}/edit")

    # Register the user into the database and move to the homepage
    $scope.handleRegister = ->
        # TODO
        return
])