login = angular.module("Login", ["SharedServices", "StartPageServices"])

login.controller("LoginController", ["$state", "$window", "$scope", "$cookieStore", "API", "StartPageStateData", "loggedIn", ($state, $window, $scope, $cookieStore, API, StartPageStateData, loggedIn) ->
    if loggedIn
        $window.location.href = "/"

    $scope.email = ""
    $scope.password = ""
    $scope.description = ""
    $scope.status = ""

    $scope.login = () ->
        API.login($scope.email, $scope.password).then(
            (result) ->
                data = result.data
                if data? and "error" not of data and "token" of data
                    token = data["token"]
                    user = $cookieStore.get("user")
                    if user?
                        user.accessToken = token
                    else
                        user = { accessToken: token }
                    $cookieStore.put("user", user)
                    $window.location.href = "/#/blah"
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
