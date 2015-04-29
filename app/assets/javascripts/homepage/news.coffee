news = angular.module("News",["SharedServices"])

news.controller("NewsController", [() ->
    loadTwitter()
])