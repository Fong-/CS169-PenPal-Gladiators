startPageServices = angular.module("StartPageServices", [])
startPageServices.service("StartPageData", () ->
    email = ""
    password = ""
    topicsById = {}
    selectedTopicIds = {}
    responseIds = {}
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
    this.getResponseIds = -> Object.keys(responseIds)
    this.addResponseId = (responseId) -> responseIds[responseId] = true
    this.clearResponseIds = -> responseIds = {}
    this.getResponseIdsAsHash = -> responseIds
    return # Required to prevent returning the last object.
)
