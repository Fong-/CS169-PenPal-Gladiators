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
    topicQuestionsDone = {} # Ids of the topics for which the questions have all been answered
    currentTopic = 0 # current topic ID, used for determining if a topic is done for progress
    latestTopic = 0 # latest topic ID
    topicsCompleted = 0 # number of topics that have been completed
    numQuestions = 0
    questionsLeft = 0
    questionsLeft_static = 0 # used for when not on the most forward topic page

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
    Object.defineProperty(this, "numQuestions", {
        get: () -> numQuestions
        set: (q) -> numQuestions = q
    })

    Object.defineProperty(this, "questionsLeft", {
        get: () -> questionsLeft
        set: (q) -> questionsLeft = q
    })

    Object.defineProperty(this, "questionsLeft_static", {
        get: () -> questionsLeft_static
        set: (q) -> questionsLeft_static = q
    })

    Object.defineProperty(this, "currentTopic", {
        get: () -> currentTopic
        set: (topicID) -> currentTopic = topicID
    })

    Object.defineProperty(this, "topicsCompleted", {
        get: () -> topicsCompleted
    })
    this.incTopicsCompleted = -> topicsCompleted += 1
    this.clearTopicsCompleted = -> topicsCompleted = 0

    Object.defineProperty(this, "latestTopic", {
        get: () -> latestTopic
        set: (topicID) -> latestTopic = topicID
    })

    Object.defineProperty(this, "topicQuestionsDone", {
        get: () -> topicQuestionsDone
        })
    this.finishedTopicQuestions = (topicId) -> topicQuestionsDone[topicId] = true
    this.isTopicQuestionsDone = (topicId) -> return topicId of topicQuestionsDone

    return
)
