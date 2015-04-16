login = angular.module("Login", ["SharedServices", "StartPageServices"])

login.controller("LoginController", ["$state", "$window", "$scope", "$cookieStore", "API", "StartPageStateData", "loggedIn", ($state, $window, $scope, $cookieStore, API, StartPageStateData, loggedIn) ->
    $scope.email = ""
    $scope.password = ""
    $scope.description = ""
    $scope.status = ""

    $scope.login = () ->
        API.login($scope.email, $scope.password).then(
            (result) ->
                data = result.data
                if data? and "error" not of data and "token" of data
                    $cookieStore.put("accessToken", data["token"])
                    $window.location.href = "/#/"
                else
                    $scope.status = if data then data["error"] else "Oops, an error occurred."
            (reason) ->
                $scope.status = "Oops, an error occurred. Try again!"
        )

    $scope.can_register = () ->
        API.canRegister($scope.email, $scope.password).then(
            (result) ->
                data = result.data
                if data? and "error" not of data
                    StartPageStateData.email = $scope.email
                    StartPageStateData.password = $scope.password
                    $state.go("topics")
                else
                    $scope.status = if data then data["error"] else "Oops, an error occurred."
            (reason) ->
                $scope.status = "Oops, an error occurred. Try again!"
        )
])
