login = angular.module("Login", [])

login.config(($routeProvider) ->
    $routeProvider.when("/", {
        templateUrl: "/assets/login.html",
        controller: "LoginController"
    })
).controller("LoginController", ["$http", "$location", "$scope", ($http, $location, $scope) ->
    $scope.email = ""
    $scope.password = ""
    $scope.description = ""
    $scope.status = ""
    $scope.login = () ->
        $http.post("/api/v1/login", {email: $scope.email, password: $scope.password}).success((data) ->
            if data && data["success"]
                document.cookie = "email=" + $scope.email
                document.cookie = "password=" + $scope.password
                alert "Logged in"
            else
                $scope.status = if data then data["error"] else "Oops, an error occurred."
        )
    $scope.register = () ->
        $http.post("/api/v1/register?email=#{$scope.email}&password=#{$scope.password}").success((data) ->
            if data && data["success"]
                document.cookie = "email=" + $scope.email
                document.cookie = "password=" + $scope.password
                $location.path("topics")
            else
                $scope.status = if data then data["error"] else "Oops, an error occurred."
        )
])