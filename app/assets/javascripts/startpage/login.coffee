login = angular.module("Login", ["SharedServices", "StartPageServices"])

login.config(["$routeProvider", ($routeProvider) ->
    $routeProvider
    .when("/", {
        templateUrl: "/assets/login.html",
        controller: "LoginController"
    })
])

login.controller("LoginController", ["$location", "$window", "$scope", "API", "StartPageStateData", ($location, $window, $scope, API, StartPageStateData) ->
    $scope.email = ""
    $scope.password = ""
    $scope.description = ""
    $scope.status = ""

    $scope.login = () ->
        API.login($scope.email, $scope.password).success((data) ->
            if data && data["success"]
                # TODO Authentication Handling
                document.cookie = "email=" + $scope.email
                document.cookie = "password=" + $scope.password
                # TODO Redirect only if the user has not yet submitted a profile.
                # TODO un-hardcode UID 1
                $window.location.href = "/home/#/profile/1"
            else
                $scope.status = if data then data["error"] else "Oops, an error occurred."
        )

    $scope.can_register = () ->
        API.canRegister($scope.email, $scope.password).success((data) ->
            if data && data["success"]
                # TODO Authentication Handling
                document.cookie = "email=" + $scope.email
                document.cookie = "password=" + $scope.password
                StartPageStateData.email = $scope.email
                StartPageStateData.password = $scope.password
                $location.path("topics")
            else
                $scope.status = if data then data["error"] else "Oops, an error occurred."
        )
])
