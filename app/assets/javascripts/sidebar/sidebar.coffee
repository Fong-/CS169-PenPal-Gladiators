sidebar = angular.module("Sidebar", ["SharedServices"])

sidebar.controller("SidebarController", ["$scope", "$http", "$location", "SharedRequests", ($scope, $http, $location, SharedRequests) ->

    data = {
        "Kevin Wu": [
            {
                "title": "Technology kills the job market",
                "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque sit amet congue elit. Donec laoreet tristique",
                "time": "4 hours ago"
            },
            {
                "title": "Is climate change real?",
                "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque sit amet congue elit. Donec laoreet tristique",
                "time": "2 days ago"
            }
        ],
        "Leo Kam": [
            {
                "title": "Technology kills the job market",
                "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque sit amet congue elit. Donec laoreet tristique",
                "time": "4 hours ago"
            },
            {
                "title": "Is climate change real?",
                "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque sit amet congue elit. Donec laoreet tristique",
                "time": "2 days ago"
            }
        ],
        "Nick Fong": [
            {
                "title": "Technology kills the job market",
                "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque sit amet congue elit. Donec laoreet tristique",
                "time": "4 hours ago"
            },
            {
                "title": "Is climate change real?",
                "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque sit amet congue elit. Donec laoreet tristique",
                "time": "2 days ago"
            }
        ]
    }
    $scope.messages = data
    $scope.gladiators = Object.keys data
    gladiatorPanelState = {}
    for gladiator in $scope.gladiators
        gladiatorPanelState["gladiator"] = false

    $scope.shouldShowGladiatorPanel = (gladiator) -> gladiatorPanelState[gladiator]
    $scope.collapseButtonText = (gladiator) -> if gladiatorPanelState[gladiator] then "" else ""
    $scope.toggleGladiatorPanel = (gladiator) ->
        gladiatorPanelState[gladiator] = !gladiatorPanelState[gladiator]
    $scope.expandButtonClass = (gladiator) -> if gladiatorPanelState[gladiator] then "glyphicon glyphicon-chevron-up" else "glyphicon glyphicon-chevron-down"
])
