//= require angular
//= require angular-ui-bootstrap
//= require angular-route
//= require_tree ./shared
//= require_tree ./startpage

app = angular.module("StartPage", ["ui.bootstrap", "ngRoute", "SharedServices", "StartPageServices", "Login", "SurveyTopics", "SurveyQuestions"])