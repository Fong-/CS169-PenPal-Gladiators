router = angular.module("Router", [])

router.config(["$stateProvider", "$urlRouterProvider", ($stateProvider, $urlRouterProvider) ->
    $urlRouterProvider.otherwise("/")

    $stateProvider
    .state("root", {
        abstract: true
        url: ""
        views: {
            navbar: {
                templateUrl: "/assets/navigation_bar.html"
                controller: "NavigationBarController"
            }
            content: {
                template: "<ui-view/>"
            }
            sidebar: {
                templateUrl: "/assets/sidebar.html"
                controller: "SidebarController"
            }
        }
        resolve: {
            loggedIn: ["Authentication", "$window", (Authentication, $window) ->
                return Authentication.isLoggedIn().then(
                    (result) -> true
                    (reason) -> $window.location.href = "/login"
                )
            ]
        }
    })
    .state("home", {
        parent: "root"
        url: "/"
        templateUrl: "/assets/home.html"
    })
    .state("profile", {
        parent: "root"
        url: "/profile/{id:int}"
        templateUrl: "/assets/profile.html"
        controller: "ProfileController"
    })
])
