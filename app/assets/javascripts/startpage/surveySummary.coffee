surveySummary = angular.module("SurveySummary", ["StartPageServices"])

surveySummary.controller("SurveySummaryController", ["$scope", "$http", "$state", "StartPageStaticData", "StartPageStateData", ($scope, $http, $state, StartPageStaticData, StartPageStateData) ->
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
        $state.go("questions", { id: topicId })

    # Register the user into the database and move to the homepage
    $scope.handleRegister = ->
        # TODO
        return
])
