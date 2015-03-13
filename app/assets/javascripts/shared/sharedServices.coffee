shares = angular.module("SharedServices", [])
shares.service("SharedRequests", ($http) ->
    SERVER_API_PREFIX = "/api/v1/"
    this.getTopics = (callback) ->
        $http.get("#{SERVER_API_PREFIX}topics").success((data, status) ->
            if status == 200 then callback(data) else callback(null)
        ).error(() ->
            callback(null)
        )

    return # Required to prevent returning the last object.
)
