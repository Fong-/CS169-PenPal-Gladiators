startPageServices = angular.module("StartPageServices", [])
startPageServices.service("StartPageData", () ->
    email = ""
    password = ""
    topicsById = {}
    selectedTopicIds = {}
    responseIdsByTopicIds = {}
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
    this.clearResponseIdsByTopics = -> responseIdsByTopicIds = {}
    this.getResponseIdsByTopicId = (topicId) -> 
        if topicId of responseIdsByTopicIds
            return responseIdsByTopicIds[topicId]
        else
            return {}
    this.getResponseIdsByTopicIds = -> responseIdsByTopicIds
    return # Required to prevent returning the last object.
)
