startPageServices = angular.module("StartPageServices", [])
startPageServices.service("StartPageData", () ->
    email = ""
    password = ""
    topicIds = {}
    responseIds = null # TODO Implement me.
    # Email interface.
    this.getEmail = -> email
    this.setEmail = (e) -> email = e
    # Password interface.
    this.getPassword = -> password
    this.setPassword = (p) -> password = p
    # Selected topics interface.
    this.getTopicIds = -> Object.keys(topicIds).sort() # Note: does NOT sort numerically.
    this.addTopicId = (topicId) -> topicIds[topicId] = true
    this.clearTopicIds = (topicId) -> topicIds = {}
    # User responses interface.
    this.getResponseIds = -> throw "SharedData::responses is not yet implemented!"
    this.addResponseId = (responseId) -> throw "SharedData::addResponse is not yet implemented!"
    return # Required to prevent returning the last object.
)
