progressBar = angular.module("ProgressBar", ["StartPageServices"])

progressBar.config(["$routeProvider", ($routeProvider) ->
    $routeProvider.when("/progress_bar", {
        templateUrl: "/assets/progress_bar.html",
        controller: "ProgresBarController"
    })
])

progressBar.controller("ProgressBarController", ["$scope", "$http", "$location", "$routeParams", "SharedRequests", "StartPageData", ($scope, $http, $location, $routeParams, SharedRequests, StartPageData) ->

    $scope.numQuestions = () -> StartPageData.getNumQuestions()
    $scope.answeredQuestions = () -> StartPageData.getAnsweredQuestions()

    $scope.percentComplete = ->
        return $scope.answeredQuestions() / $scope.numQuestions()



])
