# Assumes that questions and responses come sorted from the controller

surveyQuestions = angular.module("SurveyQuestions", ["StartPageServices"])

surveyQuestions.directive("highlighter", () ->
     (scope, element, attributes) ->
            scope.$watch(attributes.highlighter, (nv, ov) ->
                question = JSON.parse(attributes.question)
                if scope.shouldBeHighlighted(question) && !element.hasClass("highlighter")
                    element.addClass("highlighter")
                else if !scope.shouldBeHighlighted(question) && element.hasClass("highlighter")
                    element.removeClass("highlighter")
            )
)

surveyQuestions.controller("SurveyQuestionsController", ["$scope", "$http", "$state", "$stateParams", "API", "StartPageStaticData", "StartPageStateData", "questionData", ($scope, $http, $state, $stateParams, API, StartPageStaticData, StartPageStateData, questionData) ->
    $scope.allTopics = StartPageStaticData.topics                 # all the topics
    $scope.selectedTopicIds = StartPageStateData.selectedTopics     # the ids of the topics the user selected
    $scope.currentTopicId = $stateParams.id
    $scope.currentTopic = $scope.allTopics[$scope.currentTopicId].name # the topic we're doing now
    $scope.questions = StartPageStaticData.getQuestionsForTopic($scope.currentTopicId)
    $scope.questionCheckModel = StartPageStateData.getResponsesForTopic($scope.currentTopicId)

    currentState = StartPageStateData.currentState
    $scope.firstUnansweredQuestionId = null                # id of the first unanswered question on the page

    # Regex pattern to match states of the form "questions-X" where X is a 0-index
    statePattern = /^questions-(\d+)$/
    # Helper function to determine if current state refers to this page
    isCurrentState = ->
        match = currentState.match(statePattern)
        if match != null
            i = parseInt(match[1])
            if $scope.selectedTopicIds.indexOf($scope.currentTopicId) == i
                return true
        return false

    # Get the number of questions with no responses selected yet
    numUnansweredQuestions = ->
        questionsLeft = $scope.questions.length
        for question in $scope.questions
            for response in question.survey_responses
                if $scope.questionCheckModel[response.id]
                    questionsLeft -= 1
                    break

        return questionsLeft

    # Updates the progress bar when the user answers a question.
    handleProgressOnResponse = () ->
        if isCurrentState()
            questionsLeft = numUnansweredQuestions()
            StartPageStateData.setNumQuestionsCompleted($scope.questions.length - questionsLeft)

    handleProgressOnResponse()

    # Updates the progress bar when moving on to a new topic.
    handleProgressOnAdvance = () ->
        if isCurrentState()
            StartPageStateData.incrNumTopicsCompleted()
            StartPageStateData.setNumQuestionsCompleted(0)

    handleProgressQuestions = () ->
        if isCurrentState()
            StartPageStateData.setNumQuestions($scope.questions.length)

    # Get the description for the page, which changes depending on whether the user is visiting
    # a page with ALL questions answered already
    $scope.pageDescription = ->
        numQuestions = $scope.questions.length
        if isCurrentState()
            return "Answer the following #{numQuestions} questions to proceed"
        else if currentState == "summary"
            return "Edit responses and return to summary to complete registration"
        else
            return "Edit responses and press Next to continue"

    # Call this when a response is selected to toggle -- only allows one
    # response to be selected at once
    $scope.handleResponseSelected = (question, selectedResponse) ->
        for response in question.survey_responses
            $scope.questionCheckModel[response.id] = false
        $scope.questionCheckModel[selectedResponse.id] = true
        StartPageStateData.addResponsesForTopic($scope.currentTopicId, $scope.questionCheckModel)
        handleProgressOnResponse()
        $scope.firstUnansweredQuestionId = null if $scope.firstUnansweredQuestionId == question.id

    isQuestionAnswered = (question) ->
        for response in question.survey_responses
            if $scope.questionCheckModel[response.id]
                return true
        return false

    # Get the number of questions with no responses selected yet
    $scope.numUnansweredQuestions = ->
        questionsLeft = $scope.questions.length
        for question in $scope.questions
            if isQuestionAnswered(question)
                questionsLeft -= 1
        return questionsLeft

    $scope.hideBackButton = ->
        return currentState == "summary"

    $scope.disableNextButton = ->
        return numUnansweredQuestions() > 0

    # Get the text that should be displayed on the Next button
    $scope.nextButtonValue = ->
        questionsLeft = numUnansweredQuestions()
        if currentState == "summary"
            return "Save changes and return to Summary"
        else if questionsLeft == 0
            return "Next"
        else
            return "#{questionsLeft} Unanswered Question#{if numUnansweredQuestions() == 1 then '' else 's'}"

    # Helper function to advance to the summary page
    $scope.handleAdvanceToSummary = ->
        StartPageStateData.currentState = "summary"
        tmp = {}
        for topicId in $scope.selectedTopicIds
            tmp[topicId] = StartPageStateData.getResponsesForTopic(topicId)
        StartPageStateData.clearResponses()
        StartPageStateData.addResponsesForTopic(topicId, checkModel) for topicId, checkModel of tmp
        $state.go("summary")

    # Helper function to advance to the question for the next topic
    handleAdvanceToQuestions = (topicId) ->
        if isCurrentState()
            match = currentState.match(statePattern)
            i = parseInt(match[1])
            StartPageStateData.currentState = "questions-#{i+1}"

        $state.go("questions", { id: topicId })

    # Call either handleAdvanceToQuestions or handleAdvanceToSummary depending on
    # if there are more topics to answer questions for
    $scope.handleAdvance = ->
        handleProgressOnAdvance()
        nextIndex = $scope.selectedTopicIds.indexOf($scope.currentTopicId) + 1
        if currentState != "summary" && nextIndex < $scope.selectedTopicIds.length
            nextTopicId = $scope.selectedTopicIds[nextIndex]
            handleAdvanceToQuestions(nextTopicId)
        else
            $scope.handleAdvanceToSummary()

    # Helper function to move back to the topic selection page
    handleBackToTopics = ->
        $state.go("topics")

    # Helper function to move back to another question page
    handleBackToQuestions = (topicId) ->
        $state.go("questions", { id: topicId })

    # Call either handleBackToTopics or handleBackToQuestions depending on
    # if the previous page is the topic selection page or not
    $scope.handleBack = ->
        prevIndex = $scope.selectedTopicIds.indexOf($scope.currentTopicId) - 1
        if prevIndex >= 0
            prevTopicId = $scope.selectedTopicIds[prevIndex]
            handleBackToQuestions(prevTopicId)
        else
            handleBackToTopics()

    # Determine whether a question should be highlighted or not. Only the first unanswered question
    # should be highlighted.
    $scope.shouldBeHighlighted = (question) ->
        # Question is already answered or it is not the first unanswered question
        if isQuestionAnswered(question) || ($scope.firstUnansweredQuestionId != null && $scope.firstUnansweredQuestionId != question.id)
            return false
        # Question is the first unanswered question
        else
            $scope.firstUnansweredQuestionId = question.id
            return true

    # Asynchronously load the list of questions for a topic
    load_questions = (topicId) ->
        if $scope.questions.length == 0
            API.requestQuestionsByTopic(topicId)
                .success (allQuestions) ->
                    parse_questions(allQuestions)
                .error (result, status) ->
                    if result?
                        reason = result.error
                    else
                        reason = "status code #{status}"
                    console.log "topic question request failed: #{reason}"
        else
            handleProgressQuestions()

        $scope.currentTopic = $scope.allTopics[topicId].name

    # Initializing/updating the local variables using the question data from database
    parse_questions = (allQuestions) ->
        $scope.questions = []
        allQuestions = allQuestions.sort((u, v) -> u.index - v.index)
        $scope.questions = allQuestions
        StartPageStaticData.addQuestionsForTopic($scope.currentTopicId, $scope.questions)

        if Object.keys($scope.questionCheckModel).length == 0
            for question in $scope.questions
                for response in question.survey_responses
                    $scope.questionCheckModel[response.id] = false

        handleProgressQuestions()
    parse_questions(questionData.data)
])



