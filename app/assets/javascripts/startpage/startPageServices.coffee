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
    numTopics = 0
    questionsLeft = 0
    currentTopic = 0 # current topic ID, used for determining if a topic is done for progress
    topicsComplete = 0 # number of topics that have been completed

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
    this.setQuestionsLeft = (questions) -> questionsLeft = questions
    this.getQuestionsLeft = -> questionsLeft
    this.getNumTopics = -> numTopics
    this.incNumTopics = -> numTopics += 1
    this.decNumTopics = -> numTopics -= 1
    this.setCurrentTopic = (topicID) -> currentTopic = topicID # sets the id of the current topic
    this.getCurrentTopic = -> currentTopic
    this.incTopicsComplete = -> topicsComplete += 1
    this.getTopicsComplete = -> topicsComplete
    this.clearTopicsComplete = -> topicsComplete = 0
    return
)
