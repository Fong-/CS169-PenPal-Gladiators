navigationBar = angular.module("NavigationBar", ["SharedServices"])

navigationBar.controller("NavigationBarController", ["$scope", "API", "$window", "AppState", ($scope, API, $window, AppState) ->
    $scope.userId = AppState.user.id
    $scope.logout = ->
        API.logout($scope.userId).success ->
            $window.location.href = "/login"
])
