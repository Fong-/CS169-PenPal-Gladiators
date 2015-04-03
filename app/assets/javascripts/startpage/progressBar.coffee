progressBar = angular.module("ProgressBar", ["StartPageServices"])

progressBar.config(["$routeProvider", ($routeProvider) ->
    $routeProvider.when("/progress_bar", {
        templateUrl: "/assets/progress_bar.html",
        controller: "ProgresBarController"
    })
])

progressBar.controller("ProgressBarController", ["$scope", "$http", "$location", "$routeParams", "SharedRequests", "StartPageData", ($scope, $http, $location, $routeParams, SharedRequests, StartPageData) ->

    currentID = StartPageData.getCurrentTopic()

    $scope.numQuestions = () -> StartPageData.getNumQuestions()
    $scope.answeredQuestions = () -> StartPageData.getAnsweredQuestions()
    $scope.questionsLeft = () -> StartPageData.getQuestionsLeft()
    $scope.numTopics = () -> StartPageData.getNumTopics()
    $scope.isTopicDone = () -> StartPageData.isTopicQuestionsDone(currentID)
    #TODO maybe - update flag when last question is answered instead of on next page
])
