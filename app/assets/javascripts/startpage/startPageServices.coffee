startPageServices = angular.module("StartPageServices", [])

startPageServices.service("StartPageStaticData", () ->
    topics = {}
    questionsForTopics = {}

    # Topic data
    Object.defineProperty(this, "topics", {
        get: () -> topics
    })
    this.addTopic = (topic) -> topics[topic.id] = topic
    this.clearTopics = () -> topics = {}

    # Topic questions data
    Object.defineProperty(this, "questions", {
        get: () -> questionsForTopics
    })
    this.addQuestionsForTopic = (topicId, questions) ->
        questionsForTopics[topicId] = questions
    this.getQuestionsForTopic = (topicId) ->
        if topicId of questionsForTopics then questionsForTopics[topicId] else []

    return
)

startPageServices.service("StartPageStateData", () ->
    email = ""
    password = ""
    currentState = ""
    selectedTopics = {}
    responsesForSelectedTopics = {}

    # Email interface
    Object.defineProperty(this, "email", {
        get: () -> email
        set: (e) -> email = e
    })

    # Password interface
    Object.defineProperty(this, "password", {
        get: () -> password
        set: (p) -> password = p
    })

    # Global state interface
    Object.defineProperty(this, "currentState", {
        get: () -> currentState
        set: (s) -> currentState = s
    })

    # Selected topics interface
    Object.defineProperty(this, "selectedTopics", {
        get: () -> Object.keys(selectedTopics).sort() # Note: does NOT sort numerically.
    })
    this.selectTopic = (topicId) -> selectedTopics[topicId] = true
    this.clearSelectedTopics = () -> selectedTopics = {}
    this.numTopics = () -> Object.keys(selectedTopics).length

    # User responses interface
    Object.defineProperty(this, "responsesForSelectedTopics", {
        get: () -> return responsesForSelectedTopics
    })
    this.addResponsesForTopic = (topicId, responseIds) ->
        responsesForSelectedTopics[topicId] = responseIds
    this.clearResponses = () ->
        responsesForSelectedTopics = {}
    this.getResponsesForTopic = (topicId) ->
        if topicId of responsesForSelectedTopics then responsesForSelectedTopics[topicId] else {}

    # Progress bar interface
    progressBar = {
        latestTopic: 0
        topicsCompleted: 0
    }

    # Progress bar state
    Object.defineProperty(this, "progressBar", {
        get: () -> progressBar
        })
    this.getNumQuestions = -> progressBar.numQuestions
    this.setNumQuestions = (q) -> progressBar.numQuestions = q
    this.getQuestionsLeft = -> progressBar.questionsLeft
    this.setQuestionsLeft = (q) -> progressBar.questionsLeft = q
    this.getQuestionsLeft_static = -> progressBar.questionsLeft_static
    this.setQuestionsLeft_static = (q) -> progressBar.questionsLeft_static = q
    this.getCurrentTopic = -> progressBar.currentTopic
    this.setCurrentTopic = (topicId) -> progressBar.currentTopic = topicId
    this.getLatestTopic = -> progressBar.latestTopic
    this.setLatestTopic = (topicId) -> progressBar.latestTopic = topicId
    this.getTopicsCompleted = -> progressBar.topicsCompleted
    this.incTopicsCompleted = -> progressBar.topicsCompleted += 1
    this.clearTopicsCompleted = -> progressBar.topicsCompleted = 0

    topicQuestionsDone = {}
    this.getTopicQuestionsDone = () -> topicQuestionsDone
    this.finishedTopicQuestions = (topicId) -> topicQuestionsDone[topicId] = true
    this.isTopicQuestionsDone = (topicId) -> return topicId of topicQuestionsDone

    return
)
