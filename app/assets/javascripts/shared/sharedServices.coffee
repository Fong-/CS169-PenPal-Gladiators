shared = angular.module("SharedServices", [])

shared.service("API", ["$http", ($http) ->
    generateRequest = (requestString) ->
        "/api/v1/#{requestString}"

    this.requestTopics = () ->
        request = generateRequest("topics")
        $http.get(request)

    this.login = (email, password) ->
        request = generateRequest("login")
        $http.post(request, { email: email, password: password })

    this.canRegister = (email, password) ->
        request = generateRequest("register")
        params = { email: email, password: password }
        $http.get(request, { params: params })

    this.requestQuestionsByTopic = (topicId) ->
        request = generateRequest("topic/#{topicId}/survey_questions")
        $http.get(request)

    this.requestResponsesByQuestion = (questionId) ->
        request = generateRequest("survey_question/#{questionId}/survey_responses")
        $http.get(request)

    this.requestProfileByUID = (userId) ->
        request = generateRequest("user/#{userId}/profile")
        $http.get(request)

    this.updateProfileByUID = (userId, username, avatar, blurb, hero, spectrum) ->
        request = generateRequest("user/#{userId}/profile")
        params = { username: username, avatar: avatar, political_blurb: blurb, political_hero: hero, political_spectrum: spectrum}
        $http.post(request, { params: params })

    this.requestArenasByUser = (userId) ->
        request = generateRequest("arenas/#{userId}")
        $http.get(request)

    return
])

shared.service("TimeUtil", [() ->
    this.timeSince1970InSeconds = () ->
        new Date().getTime() / 1000.0

    this.timeFromTimestampInSeconds = (timestamp) ->
        Date.parse(timestamp) / 1000.0

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

    return
])
