shares = angular.module("SharedServices", [])
shares.service("SharedRequests", ["$http", ($http) ->
    SERVER_API_PREFIX = "/api/v1/"
    this.requestTopics = -> $http.get("#{SERVER_API_PREFIX}topics")
    this.login = (email, password) ->
        $http.post("#{SERVER_API_PREFIX}login", { email: email, password: password })
    this.register = (email, password) ->
        $http.post("#{SERVER_API_PREFIX}register", { email: email, password: password })
    this.can_register = (email, password) ->
        params = { email: email, password: password }
        $http.get("#{SERVER_API_PREFIX}register", { params: params })
    this.requestQuestionsByTopic = (id) ->
        $http.get("#{SERVER_API_PREFIX}topic/#{id}/survey_questions")
    this.requestResponsesByQuestion = (id) ->
        $http.get("#{SERVER_API_PREFIX}survey_question/#{id}/survey_responses")
    this.requestProfileByUID = (id) ->
        $http.get("#{SERVER_API_PREFIX}user/#{id}/profile")
    this.updateProfileByUID = (id, username, avatar, blurb, hero, spectrum) ->
        $http.post("#{SERVER_API_PREFIX}user/#{id}/profile", { username: username, avatar: avatar, political_blurb: blurb, political_hero: hero, political_spectrum: spectrum})
    this.requestArenasByUser = (id) ->
        $http.get("#{SERVER_API_PREFIX}arenas/#{id}")
    ]).service("TimeUtil", [->
    this.timeSince1970InSeconds = -> new Date().getTime() / 1000.0
    this.timeFromTimestampInSeconds = (timestamp) -> Date.parse(timestamp) / 1000.0
    this.timeIntervalAsString = (timeIntervalMs) ->
        if timeIntervalMs < 60
            return "A moment"

        if timeIntervalMs >= 31536000
            return "An eternity"

        value = 0
        unit = ""
        if timeIntervalMs < 3600
            value = Math.round(timeIntervalMs / 60.0)
            unit = "minute"
        else if timeIntervalMs < 86400
            value = Math.round(timeIntervalMs / 3600.0)
            unit = "hour"
        else if timeIntervalMs < 2592000
            value = Math.round(timeIntervalMs / 86400.0)
            unit = "day"
        else
            value = Math.round(timeIntervalMs / 2592000.0)
            unit = "month"
        return if value == 1 then "1 #{unit}" else "#{value} #{unit}s"
    return # Required to prevent returning the last object.
])
