shares = angular.module("SharedServices", [])
shares.service("SharedRequests", ($http) ->
    SERVER_API_PREFIX = "/api/v1/"
    this.requestTopics = -> $http.get("#{SERVER_API_PREFIX}topics")
    this.login = (email, password) -> $http.post("#{SERVER_API_PREFIX}login", {email: email, password: password})
    this.register = (email, password) -> $http.post("#{SERVER_API_PREFIX}register", {email: email, password: password})
    this.can_register = (email, password) -> $http.get("#{SERVER_API_PREFIX}register", {params: {email: email, password: password}})
    return # Required to prevent returning the last object.
)
