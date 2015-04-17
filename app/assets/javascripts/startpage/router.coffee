router = angular.module("Router", ["SharedServices"])

router.config(["$stateProvider", "$urlRouterProvider", ($stateProvider, $urlRouterProvider) ->
    $urlRouterProvider.otherwise("/")

    $stateProvider
    .state("login", {
        url: "/"
        templateUrl: "/assets/login.html"
        controller: "LoginController"
        resolve: {
            loggedIn: ["Authentication", "$window", "$q", (Authentication, $window, $q) ->
                return Authentication.isLoggedIn().then(
                    (result) ->
                        $window.location.href = "/"
                        return $q.reject()
                    (reason) -> false
                )
            ]
        }
    })
    .state("topics", {
        templateUrl: "/assets/survey_topics.html"
        controller: "SurveyTopicsController"
    })
    .state("survey", {
        abstract: true
        views: {
            "": {
                templateUrl: "/assets/survey.html"
            }
            "progressbar@survey": {
                templateUrl: "/assets/progress_bar.html"
                controller: "ProgressBarController"
            }
        }
    })
    .state("questions", {
        parent: "survey"
        params: { id: null }
        templateUrl: "/assets/survey_questions.html"
        controller: "SurveyQuestionsController"
    })
    .state("summary", {
        parent: "survey"
        templateUrl: "/assets/survey_summary.html"
        controller: "SurveySummaryController"
    })
])
