login = angular.module("Login", ["SharedServices", "StartPageServices"])

login.controller("LoginController", ["$state", "$window", "$scope", "$cookieStore", "API", "StartPageStateData", "loggedIn", ($state, $window, $scope, $cookieStore, API, StartPageStateData, loggedIn) ->
    $scope.email = ""
    $scope.password = ""
    $scope.description = ""
    $scope.status = ""

    $scope.login = () ->
        API.login($scope.email, $scope.password)
            .success (result) ->
                $cookieStore.put("accessToken", result["token"])
                $window.location.href = "/#/"
            .error (result) ->
                reason = result.error
                if reason is "resource not found"
                    $scope.status = "The email or password you entered is incorrect."
                else
                    $scope.status = "A server error ocurred. Try again later."


    $scope.can_register = () ->
        API.canRegister($scope.email, $scope.password)
            .success (result) ->
                StartPageStateData.email = $scope.email
                StartPageStateData.password = $scope.password
                $state.go("topics")
            .error (result) ->
                reason = result.error
                console.log "register failed: #{reason}"
                if reason is "invalid email"
                    $scope.status = "Someone already has that email. Try another?"
                else if reason is "invalid password"
                    $scope.status = "Password is invalid."
                else
                    $scope.status = "Oops, an error occurred. Try again!"
])
