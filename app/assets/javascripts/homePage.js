//= require angular
//= require angular-ui-bootstrap
//= require angular-ui-router
//= require angular-cookies
//= require ./shared/sharedServices
//= require ./shared/api
//= require_tree ./shared
//= require_tree ./homepage

function loadTwitter() {
    !function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");
}

app = angular.module("HomePage", ["ui.bootstrap", "ui.router", "ngCookies", "Router", "Profile", "Sidebar", "NavigationBar", "Conversation", "News"])