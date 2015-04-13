progressBar = angular.module("ProgressBar", ["StartPageServices"])

progressBar.config(["$routeProvider", ($routeProvider) ->
    $routeProvider.when("/progress_bar", {
        templateUrl: "/assets/progress_bar.html",
        controller: "ProgresBarController"
    })
])

progressBar.controller("ProgressBarController", ["$scope", "SharedRequests", "StartPageData", ($scope, SharedRequests, StartPageData) ->

    currentID = StartPageData.getCurrentTopic()
    percentComplete = 0

    $scope.numQuestions = () -> StartPageData.getNumQuestions()
    $scope.questionsLeft = () -> StartPageData.getQuestionsLeft()
    $scope.numTopics = () -> StartPageData.getNumTopics()
    $scope.isTopicDone = () -> StartPageData.isTopicQuestionsDone(currentID)

    # %complete = (numCompleteTopics * 100/numTopics) + (numAnsweredQuestions * 100/totalQuestions * 100/numTopics)
    # calling $scope vs calling StartPageData ???
    $scope.percentComplete = () ->
        updateCompleteTopics()

        if (currentID == StartPageData.getLatestTopic())
            numAnsweredQuestions = $scope.numQuestions() - StartPageData.getQuestionsLeft()
        else
            numAnsweredQuestions = $scope.numQuestions() - StartPageData.getQuestionsLeft_static()

        numCompleteTopics = StartPageData.getTopicsComplete()

        pastPercent = numCompleteTopics * 100 / $scope.numTopics()
        currentPercent = numAnsweredQuestions * 100 / $scope.numQuestions() / $scope.numTopics()

        percentComplete = pastPercent + currentPercent

        if percentComplete > 100
            percentComplete = 100

        return "#{percentComplete}%" # return as a string for ng-style

    # Updates the # of complete topics variable
    updateCompleteTopics = () ->
        StartPageData.clearTopicsComplete()
        for k,v of StartPageData.getTopicQuestionsDone()
            if v
                StartPageData.incTopicsComplete()
])
