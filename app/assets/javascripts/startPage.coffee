#= require angular
#= require angular-ui-bootstrap
#= require angular-route
#= require sharedServices
#= require_tree ./startPage

app = angular.module("StartPage", ["ui.bootstrap", "ngRoute", "SharedServices", "StartPageServices", "SurveyTopics"])
