# Assumes that questions and responses come sorted from the controller

surveyQuestions = angular.module("SurveyQuestions", ["StartPageServices"])

surveyQuestions.config(($routeProvider) ->
        $routeProvider.when("/questions", {
            templateUrl: "/assets/survey_questions.html",
            controller: "SurveyQuestionsController"
        })
).controller("SurveyQuestionsController", ($scope, $http, $location, SharedRequests, StartPageData) ->
    $scope.questions = []
    $scope.questionCheckModel = {}
    $scope.topicCounter = 0             # corresponds to which topic we're on
    $scope.currentTopic = ""            # the topic we're doing now
    $scope.numQuestions = 0             # the number of questions for this topic

    $scope.allTopics = StartPageData.getAllTopics()                 # all the topics
    $scope.selectedTopicIds = StartPageData.getSelectedTopicIds()   # the ids of the topics the user selected

    # Call this when a response is selected to toggle -- only allows one
    # response to be selected at once
    $scope.handleResponseSelected = (question, selectedResponse) ->
        for response in question.survey_responses
            $scope.questionCheckModel[response.id] = false
        $scope.questionCheckModel[selectedResponse.id] = true

    # Get the number of questions with no responses selected yet
    $scope.numUnansweredQuestions = ->
        questionsLeft = $scope.questions.length
        for question in $scope.questions
            for response in question.survey_responses
                if $scope.questionCheckModel[response.id]
                    questionsLeft -= 1
                    break
        return questionsLeft

    $scope.disableNextButton = ->
        return $scope.numUnansweredQuestions() > 0

    # Get the text that should be displayed on the Next button
    $scope.nextButtonValue = ->
        questionsLeft = $scope.numUnansweredQuestions()
        if questionsLeft == 0
            return "Next"
        else
            return "#{questionsLeft} Unanswered Questions"

    # Helper function to advance to the summary page
    handleAdvanceToSummary = ->
        StartPageData.clearResponseIds()
        StartPageData.addResponseId(id) for id of $scope.questionCheckModel when $scope.questionCheckModel[id]
        $location.path("summary")

    # Helper function to advance to the question for the next topic
    handleAdvanceToQuestions = ->
        load_questions($scope.selectedTopicIds[$scope.topicCounter])

    # Call either handleAdvanceToQuestions or handleAdvanceToSummary depending on
    # if there are more topics to answer questions for
    $scope.handleAdvance = ->
        $scope.topicCounter += 1
        if $scope.topicCounter < $scope.selectedTopicIds.length
            handleAdvanceToQuestions()
        else
            handleAdvanceToSummary()

    # Helper function to move back to the topic selection page
    handleBackToTopics = ->
        $location.path("topics")

    # Helper function to move back to another question page
    handleBackToQuestions = ->
        load_questions($scope.selectedTopicIds[$scope.topicCounter])

    # Call either handleBackToTopics or handleBackToQuestions depending on
    # if the previous page is the topic selection page or not
    $scope.handleBack = ->
        if $scope.topicCounter > 0
            $scope.topicCounter -= 1
            handleBackToQuestions()
        else
            handleBackToTopics()

    

    # Asynchronously load the list of questions for a topic
    load_questions = (topicId) ->
        SharedRequests.requestQuestionsByTopic(topicId).success( (allQuestions) ->
            $scope.questions = []
            allQuestions = allQuestions.sort((u, v) -> u.index - v.index)
            for question in allQuestions
                $scope.questions.push(question)
            $scope.numQuestions = $scope.questions.length
        )
        $scope.currentTopic = $scope.allTopics[topicId].name


    load_questions($scope.selectedTopicIds[0])
)