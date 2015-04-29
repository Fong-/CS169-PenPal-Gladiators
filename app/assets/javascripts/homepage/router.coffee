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
            "sidebar-matching@root": {
                templateUrl: "/assets/sidebar_matching.html"
                controller: "SidebarMatchesController"
            }
        }
        resolve: {
            loggedIn: ["Authentication", "$window", "$q", (Authentication, $window, $q) ->
                return Authentication.isLoggedIn().then(
                    (result) -> true
                    (reason) ->
                        $window.location.href = "/login"
                        return $q.reject()
                )
            ]
        }
    })
    .state("home", {
        parent: "root"
        url: "/"
        templateUrl: "/assets/home.html"
        controller: "NewsController"
    })
    .state("profile", {
        parent: "root"
        url: "/profile/{id:int}"
        templateUrl: "/assets/profile.html"
        controller: "ProfileController"
    })
    .state("conversation", {
        parent: "root"
        url: "/conversation/{id:int}"
        templateUrl: "/assets/conversation.html"
        controller: "ConversationController"
    })
])
