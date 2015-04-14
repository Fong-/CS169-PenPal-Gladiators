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
            }
            content: {
                template: "<ui-view/>"
            }
            sidebar: {
                templateUrl: "/assets/sidebar.html"
                controller: "SidebarController"
            }
        }
    })
    .state("home", {
        parent: "root"
        url: "/"
        templateUrl: "/assets/home.html"
        resolve: {
            loggedIn: ["Authentication", (Authentication) -> Authentication.isLoggedIn()]
        }
    })
    .state("profile", {
        parent: "root"
        url: "/profile/{id:int}"
        templateUrl: "/assets/profile.html"
        controller: "ProfileController"
        resolve: {
            loggedIn: ["Authentication", (Authentication) -> Authentication.isLoggedIn()]
        }
    })
])
