shares = angular.module("SharedServices", [])
shares.service("SharedRequests", ($http) ->
    SERVER_API_PREFIX = "/api/v1/"
    this.requestTopics = -> $http.get("#{SERVER_API_PREFIX}topics")
    return # Required to prevent returning the last object.
)
