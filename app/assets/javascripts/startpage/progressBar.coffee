progressBar = angular.module("ProgressBar", ["StartPageServices"])

progressBar.config(["$routeProvider", ($routeProvider) ->
    $routeProvider.when("/progress_bar", {
        templateUrl: "/assets/progress_bar.html",
        controller: "ProgresBarController"
    })
])

progressBar.controller("ProgressBarController", ["$scope", "$http", "$location", "$routeParams", "SharedRequests", "StartPageData", ($scope, $http, $location, $routeParams, SharedRequests, StartPageData) ->

    $scope.somevariable = 5

    $scope.numQuestions = StartPageData.getNumQuestions() # get total number of all questions
    $scope.answeredQuestions = StartPageData.getAnsweredQuestions() # get number of answered questions

    $scope.percentComplete = ->
        return $scope.answeredQuestions / $scope.numQuestions



])
