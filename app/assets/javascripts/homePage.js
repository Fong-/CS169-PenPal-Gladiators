//= require angular
//= require angular-ui-bootstrap
//= require angular-ui-router
//= require_tree ./shared
//= require_tree ./sidebar
//= require_tree ./profile

app = angular.module("HomePage", ["ui.bootstrap", "ui.router", "Profile", "Sidebar"])
