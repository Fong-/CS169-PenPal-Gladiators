router = angular.module("Router", ["SharedServices"])

router.config(["$stateProvider", "$urlRouterProvider", ($stateProvider, $urlRouterProvider) ->
    $urlRouterProvider.otherwise("/")

    $stateProvider
    .state("login", {
        url: "/"
        templateUrl: "/assets/login.html"
        controller: "LoginController"
        resolve: {
            loggedIn: ["Authentication", (Authentication) ->
                return Authentication.isLoggedIn(false).then(
                    (result) -> true
                    (reason) -> false
                )
            ]
        }
    })
    .state("topics", {
        templateUrl: "/assets/survey_topics.html"
        controller: "SurveyTopicsController"
    })
    .state("questions", {
        templateUrl: "/assets/survey_questions.html"
        controller: "SurveyQuestionsController"
        params: { id: null }
    })
    .state("questionsEdit", {
        templateUrl: "/assets/survey_questions.html"
        controller: "SurveyQuestionsController"
        params: { id: null }
    })
    .state("summary", {
        templateUrl: "/assets/survey_summary.html"
        controller: "SurveySummaryController"
    })
])
