//= require angular
//= require angular-ui-bootstrap
//= require angular-route
//= require_tree ./shared
//= require_tree ./sidebar
//= require_tree ./homepage
//= require_tree ./profile

app = angular.module("HomePage", ["ui.bootstrap", "ngRoute", "SharedServices", "Profile", "Sidebar"])
