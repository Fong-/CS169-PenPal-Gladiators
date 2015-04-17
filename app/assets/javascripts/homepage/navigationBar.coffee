navigationBar = angular.module("NavigationBar", ["SharedServices"])

navigationBar.controller("NavigationBarController", ["$scope", "AppState", ($scope, AppState) ->
    $scope.userId = AppState.user.id
])
