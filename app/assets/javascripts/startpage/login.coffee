login = angular.module("Login", ["SharedServices", "StartPageServices"])

login.controller("LoginController", ["$state", "$window", "$scope", "API", "StartPageStateData", ($state, $window, $scope, API, StartPageStateData) ->
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
                $state.go("topics")
            else
                $scope.status = if data then data["error"] else "Oops, an error occurred."
        )
])
