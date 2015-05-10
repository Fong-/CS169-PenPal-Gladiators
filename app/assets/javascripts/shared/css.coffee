css = angular.module("CSS", ["SharedServices"])

css.controller("CSS", ["$scope", "AppState", ($scope, AppState) ->
    self = this

    self.setThemeFromSaved = () ->
        $scope.cssOption = AppState.theme

    self.setThemeFromSaved()

    $scope.toggleTheme = () ->
        if $scope.cssOption == "light"
            AppState.setTheme("dark")
            self.setThemeFromSaved()
        else
            AppState.setTheme("light")
            self.setThemeFromSaved()

    $scope.toggleButtonClass = () ->
        if $scope.cssOption == 'light' then '' else 'select-default'
])