startPageServices = angular.module("StartPageServices", [])
startPageServices.service("StartPageData", () ->
    email = ""
    password = ""
    topicsById = {}
    selectedTopicIds = {}
    responseIdsByTopicIds = {}
    questionsByTopicIds = {}
    topicSelectionDone = false
    topicQuestionsDone = {}           # Ids of the topics for which the questions have all been answered

    numQuestions = 0 # number of all questions in every topic
    answeredQuestions = 0 # number of answered questions
    numTopics = 0

    # Email interface.
    this.getEmail = -> email
    this.setEmail = (e) -> email = e
    # Password interface.
    this.getPassword = -> password
    this.setPassword = (p) -> password = p
    # Topics by topic id.
    this.getAllTopics = -> topicsById
    this.addTopic = (topic) -> topicsById[topic.id] = topic
    this.clearAllTopics = -> topicsById = {}
    # Selected topics interface.
    this.getSelectedTopicIds = -> Object.keys(selectedTopicIds).sort() # Note: does NOT sort numerically.
    this.addSelectedTopicId = (topicId) -> selectedTopicIds[topicId] = true
    this.clearSelectedTopicIds = (topicId) -> selectedTopicIds = {}
    this.finishedTopicSelection = -> topicSelectionDone = true
    this.isTopicSelectionDone = -> return topicSelectionDone
    # User responses interface.
    # Get ids of responses selected by user
    this.getResponseIds = ->
        responseIds = []
        for _topicId, responseIds in responseIdsByTopicIds
            for id, selected in responseIds
                if selected
                    resposneIds.push(id)
        return responseIds
    this.addResponseIdsByTopicId = (topicId, responseIdsByTopicId) ->
        responseIdsByTopicIds[topicId] = responseIdsByTopicId
        answeredQuestions += 1 # increment answered questions counter by 1

    this.clearResponseIdsByTopics = -> responseIdsByTopicIds = {}
    this.getResponseIdsByTopicId = (topicId) ->
        if topicId of responseIdsByTopicIds
            return responseIdsByTopicIds[topicId]
        else
            return {}
    this.getResponseIdsByTopicIds = -> responseIdsByTopicIds
    this.addTopicQuestions = (topicId, questions) ->
        questionsByTopicIds[topicId] = questions
        numTopics += 1
    this.getTopicQuestions = (topicId) ->
        if topicId of questionsByTopicIds then questionsByTopicIds[topicId] else []
    this.getAllQuestions = -> return questionsByTopicIds
    this.finishedTopicQuestions = (topicId) -> topicQuestionsDone[topicId] = true
    this.isTopicQuestionsDone = (topicId) -> return topicId of topicQuestionsDone

    # Progress bar interface
    this.setNumQuestions = (questions) -> numQuestions = questions # sets the number of questions on current topic
    this.getNumQuestions = -> numQuestions
    this.incrementAnsweredQuestions = -> answeredQuestions += 1
    this.getAnsweredQuestions = -> answeredQuestions
    # this.incrementNumTopics = -> numTopics += 1
    this.getNumTopics = -> numTopics


    return # Required to prevent returning the last object.
)
