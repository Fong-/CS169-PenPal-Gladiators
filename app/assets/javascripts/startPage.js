//= require angular
//= require angular-ui-bootstrap
//= require angular-ui-router
//= require angular-cookies
//= require ./shared/sharedServices
//= require ./shared/api
//= require_tree ./shared
//= require_tree ./startpage

app = angular.module("StartPage", ["ui.bootstrap", "ui.router", "ngCookies", "Router", "Login", "SurveyTopics", "SurveyQuestions", "SurveySummary"])
