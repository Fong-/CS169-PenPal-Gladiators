progressBar = angular.module("ProgressBar", ["StartPageServices"])

progressBar.config(["$routeProvider", ($routeProvider) ->
    $routeProvider.when("/progress_bar", {
        templateUrl: "/assets/progress_bar.html",
        controller: "ProgresBarController"
    })
])

progressBar.controller("ProgressBarController", ["$scope", "StartPageStateData", ($scope, StartPageStateData) ->

    currentID = StartPageStateData.currentTopic
    percentComplete = 0

    $scope.numQuestions = () -> StartPageStateData.numQuestions
    $scope.questionsLeft = () -> StartPageStateData.questionsLeft
    $scope.numTopics = () -> StartPageStateData.numTopics()
    $scope.isTopicDone = () -> StartPageStateData.isTopicQuestionsDone(currentID)
    $scope.topicsCompleted = () -> StartPageStateData.topicsCompleted

    # %complete = (numCompleteTopics * 100/numTopics) + (numAnsweredQuestions * 100/totalQuestions * 100/numTopics)
    $scope.percentComplete = () ->
        updateCompletedTopics()

        if (currentID == StartPageStateData.latestTopic)
            numAnsweredQuestions = $scope.numQuestions() - StartPageStateData.questionsLeft
        else
            numAnsweredQuestions = $scope.numQuestions() - StartPageStateData.questionsLeft_static

        numCompletedTopics = StartPageStateData.topicsCompleted

        pastPercent = numCompletedTopics * 100 / $scope.numTopics()
        currentPercent = numAnsweredQuestions * 100 / $scope.numQuestions() / $scope.numTopics()

        percentComplete = pastPercent + currentPercent

        if percentComplete > 100
            percentComplete = 100

        return "#{percentComplete}%" # return as a string for ng-style

    # Updates the # of complete topics
    updateCompletedTopics = () ->
        StartPageStateData.clearTopicsCompleted()
        for k,v of StartPageStateData.topicQuestionsDone
            if v
                StartPageStateData.incTopicsCompleted()
])
