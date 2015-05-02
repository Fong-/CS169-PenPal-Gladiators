css = angular.module("CSS", ["SharedServices"])

css.controller("CSS", ["AppState", (AppState) ->
    self = this

    self.setThemeFromSaved = () ->
        self.cssOption = AppState.theme

    self.cssOption = self.setThemeFromSaved()

    self.toggleTheme = () ->
        if self.cssOption == "Light"
            AppState.setTheme("")
            self.setThemeFromSaved()
        else
            AppState.setTheme("Light")
            self.setThemeFromSaved()

    self.buttonClass = () ->
        if self.cssOption == '' then '' else 'select-default'
])
