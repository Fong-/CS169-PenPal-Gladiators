//= require angular
//= require angular-ui-bootstrap
//= require angular-route
//= require_tree ./shared
//= require_tree ./startpage

app = angular.module("StartPage", ["ui.bootstrap", "ngRoute", "Login", "SurveyTopics", "SurveyQuestions", "SurveySummary"])
