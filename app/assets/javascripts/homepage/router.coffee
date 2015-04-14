router = angular.module("Router", [])

router.config(["$stateProvider", "$urlRouterProvider", ($stateProvider, $urlRouterProvider) ->
    $urlRouterProvider.otherwise("/")

    $stateProvider
    .state("home", {
        url: "/"
        template: ""
        resolve: {
            loggedIn: ["Authentication", (Authentication) -> Authentication.isLoggedIn()]
        }
    })
    .state("profile", {
        url: "/profile/{id:int}"
        templateUrl: "/assets/profile.html"
        controller: "ProfileController"
        resolve: {
            loggedIn: ["Authentication", (Authentication) -> Authentication.isLoggedIn()]
        }
    })
])
