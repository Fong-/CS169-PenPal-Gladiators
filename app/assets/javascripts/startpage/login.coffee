login = angular.module("Login", ["SharedServices", "StartPageServices"])

login.config(["$routeProvider", ($routeProvider) ->
    $routeProvider.when("/", {
        templateUrl: "/assets/login.html",
        controller: "LoginController"
    })
]).controller("LoginController", ["$http", "$location", "$scope", "SharedRequests", "StartPageData", ($http, $location, $scope, SharedRequests, StartPageData) ->
    $scope.email = ""
    $scope.password = ""
    $scope.description = ""
    $scope.status = ""
    $scope.login = () ->
        SharedRequests.login($scope.email, $scope.password).success((data) ->
            if data && data["success"]
                document.cookie = "email=" + $scope.email
                document.cookie = "password=" + $scope.password
                alert "Logged in"
            else
                $scope.status = if data then data["error"] else "Oops, an error occurred."
        )
    $scope.can_register = () ->
        SharedRequests.can_register($scope.email, $scope.password).success((data) ->
            if data && data["success"]
                document.cookie = "email=" + $scope.email
                document.cookie = "password=" + $scope.password
                StartPageData.setEmail($scope.email)
                StartPageData.setPassword($scope.password)
                $location.path("topics")
            else
                $scope.status = if data then data["error"] else "Oops, an error occurred."
        )
])
