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

    numQuestions = 0 # number of all questions in every topic
    answeredQuestions = 0 # number of answered questions
    numTopics = 0

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
    this.setNumQuestions = (questions) -> numQuestions = questions # sets the number of questions on current topic
    this.getNumQuestions = -> numQuestions
    this.incrementAnsweredQuestions = -> answeredQuestions += 1
    this.getAnsweredQuestions = -> answeredQuestions

    # this.incrementNumTopics = -> numTopics += 1
    this.getNumTopics = -> numTopics

    return
)
