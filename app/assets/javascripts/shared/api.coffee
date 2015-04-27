angular.module("SharedServices").service("API", ["$http", "$cookieStore", ($http, $cookieStore) ->

    generateRequest = (requestString) ->
        "/api/v1/#{requestString}"

    getToken = () ->
        return $cookieStore.get("accessToken")

    this.logout = (id) ->
        request = generateRequest("logout/#{id}")
        $http.post(request, { token: getToken() })

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

    this.editSummaryByConversationId = (conversationId, text) ->
        request = generateRequest("conversation/edit_summary/#{conversationId}")
        $http.post(request, { text: text, token: getToken() })

    this.approveSummaryByConversationId = (conversationId) ->
        request = generateRequest("conversation/approve_summary/#{conversationId}")
        $http.post(request, { token: getToken() })

    this.editResolutionByConversationId = (conversationId, text) ->
        request = generateRequest("conversation/edit_resolution/#{conversationId}")
        $http.post(request, { text: text, token: getToken() })

    this.approveResolutionByConversationId = (conversationId) ->
        request = generateRequest("conversation/approve_resolution/#{conversationId}")
        $http.post(request, { token: getToken() })

    return
])
