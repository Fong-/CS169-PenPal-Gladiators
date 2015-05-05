shared = angular.module("SharedServices", [])

shared.directive("onEscape", ->
    (scope, element, attributes) ->
        element.bind("keydown keypress", (event) ->
            if event.which == 27
                scope.$apply(-> scope.$eval(attributes.onEscape))
                event.preventDefault()
        )
)

shared.directive("onEnter", ->
    (scope, element, attributes) ->
        element.bind("keydown keypress", (event) ->
            if event.which == 13
                scope.$apply(-> scope.$eval(attributes.onEnter))
                event.preventDefault()
        )
)
