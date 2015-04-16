progressBar = angular.module("ProgressBar", ["StartPageServices"])

progressBar.controller("ProgressBarController", ["$scope", "StartPageStateData", ($scope, StartPageStateData) ->

    currentID = StartPageStateData.progressBar.currentTopic
    percentComplete = 0

    $scope.numQuestions = () -> StartPageStateData.progressBar.numQuestions
    $scope.questionsLeft = () -> StartPageStateData.progressBar.questionsLeft
    $scope.numTopics = () -> StartPageStateData.numTopics()
    $scope.percentComplete = () ->
        updateCompletedTopics()

        if (currentID == StartPageStateData.progressBar.latestTopic)
            numAnsweredQuestions = $scope.numQuestions() - $scope.questionsLeft()
        else
            numAnsweredQuestions = $scope.numQuestions() - StartPageStateData.progressBar.questionsLeft_static
        numCompletedTopics = StartPageStateData.progressBar.topicsCompleted

        pastPercent = numCompletedTopics * 100 / $scope.numTopics()
        currentPercent = numAnsweredQuestions * 100 / $scope.numQuestions() / $scope.numTopics()
        percentComplete = pastPercent + currentPercent
        if percentComplete > 100
            percentComplete = 100

        return "#{percentComplete}%" # return as a string for ng-style

    # Updates the # of complete topics
    updateCompletedTopics = () ->
        StartPageStateData.clearTopicsCompleted()
        for k,v of StartPageStateData.getTopicQuestionsDone()
            if v then StartPageStateData.incTopicsCompleted()
])
