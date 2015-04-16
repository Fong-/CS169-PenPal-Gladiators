surveySummary = angular.module("SurveySummary", ["StartPageServices"])

surveySummary.controller("SurveySummaryController", ["$scope", "$http", "$state", "$cookieStore", "$window", "StartPageStaticData", "StartPageStateData", "API", ($scope, $http, $state, $cookieStore, $window, StartPageStaticData, StartPageStateData, API) ->
    $scope.submitRegistrationText = "Finish Registration"
    $scope.disableRegistration = false

    # Save user selected topics
    $scope.selectedTopics = {}
    allTopics = StartPageStaticData.topics
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
        $scope.submitRegistrationText = "Registering..."
        $scope.disableRegistration = true
        API.register(StartPageStateData.email, StartPageStateData.password)
            .success (result) ->
                $cookieStore.put("accessToken", result["token"])
                $window.location.href = "/#/"
            .error (result) ->
                $scope.status = "Oops, an error occurred. Try again!"
            .finally () ->
                $scope.submitRegistrationText = "Try Again"
                $scope.disableRegistration = false

        return
])
