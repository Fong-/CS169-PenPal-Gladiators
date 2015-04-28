//= require angular
//= require angular-ui-bootstrap
//= require angular-ui-router
//= require angular-cookies
//= require ./shared/sharedServices
//= require ./shared/api
//= require_tree ./shared
//= require_tree ./homepage

app = angular.module("HomePage", ["ui.bootstrap", "ui.router", "ngCookies", "Router", "Profile", "Sidebar", "NavigationBar", "Conversation"])