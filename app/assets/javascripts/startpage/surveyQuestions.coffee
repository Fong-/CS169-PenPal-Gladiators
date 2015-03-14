# Assumes that questions and responses come sorted from the controller

surveyQuestions = angular.module("SurveyQuestions", ["StartPageServices"])

surveyQuestions.config(($routeProvider) ->
        $routeProvider.when("/questions/:id", {
            templateUrl: "/assets/survey_questions.html",
            controller: "SurveyQuestionsController"
        })
).controller("SurveyQuestionsController", ($scope, $http, $location, $routeParams, SharedRequests, StartPageData) ->
    $scope.allTopics = StartPageData.getAllTopics()                 # all the topics
    $scope.selectedTopicIds = StartPageData.getSelectedTopicIds()   # the ids of the topics the user selected
    $scope.currentTopicId = $routeParams.id
    $scope.currentTopic = $scope.allTopics[$scope.currentTopicId].name # the topic we're doing now
    
    $scope.questions = []
    $scope.questionCheckModel = StartPageData.getResponseIdsByTopicId($scope.currentTopicId)
    #if Object.keys($scope.questionCheckModel).length == 0
    #    $scope.test2 = "Answerse not saved"
    #else
    #    $scope.test2 = "Answeres saved!"
    $scope.numQuestions = 0             # the number of questions for this topic


    # Call this when a response is selected to toggle -- only allows one
    # response to be selected at once
    $scope.handleResponseSelected = (question, selectedResponse) ->
        for response in question.survey_responses
            $scope.questionCheckModel[response.id] = false
        $scope.questionCheckModel[selectedResponse.id] = true
        StartPageData.addResponseIdsByTopicId($scope.currentTopicId, $scope.questionCheckModel)

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
        tmp = {}
        for topicId in $scope.selectedTopicIds
            tmp[topicId] = StartPageData.getResponseIdsByTopicId(topicId)
        StartPageData.clearResponseIdsByTopics()
        StartPageData.addResponseIdsByTopicId(topicId, checkModel) for topicId, checkModel of tmp
        $location.path("summary")

    # Helper function to advance to the question for the next topic
    handleAdvanceToQuestions = (topicId) ->
        $location.path("questions/#{topicId}")

    # Call either handleAdvanceToQuestions or handleAdvanceToSummary depending on
    # if there are more topics to answer questions for
    $scope.handleAdvance = ->
        nextIndex = $scope.selectedTopicIds.indexOf($scope.currentTopicId) + 1
        if nextIndex < $scope.selectedTopicIds.length
            nextTopicId = $scope.selectedTopicIds[nextIndex]
            handleAdvanceToQuestions(nextTopicId)
        else
            handleAdvanceToSummary()

    # Helper function to move back to the topic selection page
    handleBackToTopics = ->
        $location.path("topics")

    # Helper function to move back to another question page
    handleBackToQuestions = (topicId) ->
        $location.path("questions/#{topicId}")

    # Call either handleBackToTopics or handleBackToQuestions depending on
    # if the previous page is the topic selection page or not
    $scope.handleBack = ->
        prevIndex = $scope.selectedTopicIds.indexOf($scope.currentTopicId) - 1
        if prevIndex >= 0
            prevTopicId = $scope.selectedTopicIds[prevIndex]
            handleBackToQuestions(prevTopicId)
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
        if Object.keys($scope.questionCheckModel).length == 0
            for question in $scope.questions
                for response in question.survey_responses
                    $scope.questionCheckModel[response.id] = false


    load_questions($scope.currentTopicId)
)