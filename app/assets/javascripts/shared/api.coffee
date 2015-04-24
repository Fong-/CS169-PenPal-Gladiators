angular.module("SharedServices").service("API", ["$http", "$cookieStore", ($http, $cookieStore) ->

    generateRequest = (requestString) ->
        "/api/v1/#{requestString}"

    getToken = () ->
        return $cookieStore.get("accessToken")

    this.requestTopics = () ->
        request = generateRequest("topics")
        $http.get(request)

    this.authenticate = () ->
        request = generateRequest("authenticate")
        params = { token: getToken() }
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
        params = { token: getToken() }
        $http.get(request, { params: params })

    this.updateProfileByUID = (userId, username, avatar, blurb, hero, spectrum) ->
        request = generateRequest("user/#{userId}/profile")
        params = { username: username, avatar: avatar, political_blurb: blurb, political_hero: hero, political_spectrum: spectrum, token: getToken() }
        $http.post(request, params)

    this.requestArenasByUser = (userId) ->
        request = generateRequest("arenas/#{userId}")
        params = { token: getToken() }
        $http.get(request, { params: params })

    this.requestConversationById = (id) ->
        request = generateRequest("conversation/#{id}")
        $http.get(request, { params: { token: getToken() } })

    this.createPostByConversationId = (id, text) ->
        request = generateRequest("post/create/#{id}")
        $http.post(request, { text: text, token: getToken() })

    this.editPostById = (id, text) ->
        request = generateRequest("post/edit/#{id}")
        $http.post(request, { text: text, token: getToken() })

    this.requestMatches = (userId) ->
        request = generateRequest("matches")
        params = { token: getToken(), id: userId }
        $http.get(request, { params: params })

    this.requestMatch = (myUserId, otherUserId) ->
        request = generateRequest("send_request")
        params = { token: getToken(), my_id: myUserId, user_id: otherUserId }
        $http.post(request, { params: params })

    this.incomingRequests = (userId) ->
        request = generateRequest("incoming_requests")
        params = { token: getToken(), id: userId }
        $http.get(request, { params: params })

    this.respondToRequest = (userId, otherUserId, userResponse) ->
        request = generateRequest("modify_request")
        params = { token: getToken(), id: userId, user_id: otherUserId, response: userResponse }
        $http.post(request, { params: params })

    this.requestStatus = (userId) ->
        request = generateRequest("sent_requests")
        params = { token: getToken(), id: userId }
        $http.get(request, { params: params })

    return
])
