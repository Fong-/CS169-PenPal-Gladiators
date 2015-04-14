login = angular.module("Login", ["SharedServices", "StartPageServices"])

login.controller("LoginController", ["$state", "$window", "$scope", "API", "StartPageStateData", "loggedIn", ($state, $window, $scope, API, StartPageStateData, loggedIn) ->
    if loggedIn
        $window.location.href = "/"

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
                $window.location.href = "/#/profile/1"
            else
                $scope.status = if data then data["error"] else "Oops, an error occurred."
        )

    $scope.can_register = () ->
        API.canRegister($scope.email, $scope.password).success((data) ->
            if "error" of data
                $scope.status = if data then data["error"] else "Oops, an error occurred."
            else
                StartPageStateData.email = $scope.email
                StartPageStateData.password = $scope.password
                $state.go("topics")
        )
])
