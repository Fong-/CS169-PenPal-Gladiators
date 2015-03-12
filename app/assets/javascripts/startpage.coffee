//= require angular
//= require angular-ui-bootstrap
//= require angular-route
//= require_tree ./startpage

app = angular.module("StartPage", ["ui.bootstrap", "ngRoute", "SurveyTopics", "surveyQuestions"])
