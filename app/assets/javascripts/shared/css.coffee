css = angular.module("CSS", ["SharedServices"])

css.controller("CSS", ["$scope", "AppState", ($scope, AppState) ->
    DEFAULT_THEME = "dark"

    $scope.setThemeFromSaved = () ->
        if not AppState.theme? or AppState.theme is ""
            AppState.setTheme("dark")

        $scope.theme = AppState.theme

    $scope.setThemeFromSaved()
])
