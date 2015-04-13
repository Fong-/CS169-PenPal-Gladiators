//= require angular
//= require angular-ui-bootstrap
//= require angular-ui-router
//= require angular-route
//= require_tree ./shared
//= require_tree ./startpage

app = angular.module("StartPage", ["ui.bootstrap", "ui.router", "Router", "Login", "SurveyTopics", "SurveyQuestions", "SurveySummary"])
