progressBar = angular.module("ProgressBar", ["StartPageServices"])

progressBar.config(["$routeProvider", ($routeProvider) ->
    $routeProvider.when("/progress_bar", {
        templateUrl: "/assets/progress_bar.html",
        controller: "ProgresBarController"
    })
])

progressBar.controller("ProgressBarController", ["$scope", "$http", "$location", "$routeParams", "SharedRequests", "StartPageData", ($scope, $http, $location, $routeParams, SharedRequests, StartPageData) ->

    currentID = StartPageData.getCurrentTopic()
    percentComplete = 0

    $scope.numQuestions = () -> StartPageData.getNumQuestions()
    $scope.questionsLeft = () -> StartPageData.getQuestionsLeft()
    $scope.numTopics = () -> StartPageData.getNumTopics()
    $scope.isTopicDone = () -> StartPageData.isTopicQuestionsDone(currentID)
    $scope.topicsComplete = () -> StartPageData.getTopicsComplete()

    #debugging
    $scope.currentID = () -> currentID
    $scope.latestID = () -> StartPageData.getLatestTopic()

    # %complete = (numCompleteTopics * 100/numTopics) + (numAnsweredQuestions * 100/totalQuestions * 100/numTopics)
    # calling $scope vs calling StartPageData ???
    $scope.percentComplete = () ->
        updateCompleteTopics() # update complete topics first

        if (currentID == StartPageData.getLatestTopic())
            numAnsweredQuestions = $scope.numQuestions() - StartPageData.getQuestionsLeft()
        else
            numAnsweredQuestions = $scope.numQuestions() - StartPageData.getQuestionsLeft_static()

        numCompleteTopics = StartPageData.getTopicsComplete()

        pastPercent = numCompleteTopics * 100 / $scope.numTopics()
        currentPercent = numAnsweredQuestions * 100 / $scope.numQuestions() / $scope.numTopics()

        percentComplete = pastPercent + currentPercent

        if percentComplete > 100 # might need to change this later because it might break stuff
            percentComplete = 100

        n = percentComplete.toString() # ng-style needs a string
        return n + "%"

    # Updates the # of complete topics variable
    updateCompleteTopics = () ->
        StartPageData.clearTopicsComplete()
        for k,v of StartPageData.getTopicQuestionsDone()
            if v
                StartPageData.incTopicsComplete()

    #TODO maybe - update flag when last question is answered instead of on next page
])
