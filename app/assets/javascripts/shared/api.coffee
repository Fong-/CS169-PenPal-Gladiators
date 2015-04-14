angular.module("SharedServices").service("API", ["$http", ($http) ->
    generateRequest = (requestString) ->
        "/api/v1/#{requestString}"

    this.requestTopics = () ->
        request = generateRequest("topics")
        $http.get(request)

    this.authenticate = (token) ->
        request = generateRequest("authenticate")
        params = { token: token }
        $http.get(request, { params: params })

    this.login = (email, password) ->
        request = generateRequest("login")
        $http.post(request, { email: email, password: password })

    this.register = (email, password) ->
        request = generateRequest("register")
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
        $http.post(request, params)

    this.requestArenasByUser = (userId) ->
        request = generateRequest("arenas/#{userId}")
        $http.get(request)

    return
])
