# Assumes that questions and responses come sorted from the controller

surveyQuestions = angular.module("SurveyQuestions", [])

surveyQuestions.config(($routeProvider) ->
        $routeProvider.when("/questions", {
            templateUrl: "/assets/survey_questions.html",
            controller: "SurveyQuestionsController"
        })
).controller("SurveyQuestionsController", ($scope, $http, $location, $routeParams) ->
    $scope.questions = []
    $scope.questionCheckModel = {}
    $scope.topicCounter = 0             # corresponds to which topic we're on
    $scope.currentTopic = ""            # the topic we're doing now
    $scope.numQuestions = 0             # the number of questions for this topic

    # TODO: Replace with call(s) to grab the actual topic ids from storage
    $scope.topicIds = [1,2,3]           # the ids of the topics the user selected

    # Call this when a response is selected to toggle -- only allows one
    # response to be selected at once
    $scope.handleResponseSelected = (question, selectedResponse) ->
        for response in question.possibleResponses
            $scope.questionCheckModel[response.id] = false
        $scope.questionCheckModel[selectedResponse.id] = true

    # Get the number of questions with no responses selected yet
    $scope.numUnansweredQuestions = ->
        questionsLeft = $scope.questions.length
        for question in $scope.questions
            for response in question.possibleResponses
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
    $scope.handleAdvanceToSummary = ->
        $location.path("summary")

    # Helper function to advance to the question for the next topic
    $scope.handleAdvanceToQuestion = ->
        # Placeholder for now
        $scope.topicCounter += 0
#        mock_load_questions (questions) ->
#            $scope.questions = questions.sort((u, v) -> u.index - v.index)
#            $scope.currentTopic = "Testing"
#            $scope.numQuestions = $scope.questions.length
#            #TODO: Figure out how to persist state between forward and backward movement within form
#            for question in $scope.questions
#                for response in question.possibleResponses
#                    $scope.questionCheckModel[response.id] = false
#            $scope.$apply()

    # Call either handleAdvanceToQuestion or handleAdvanceToSummary depending on
    # if there are more topics to answer questions for
    $scope.handleAdvance = ->
        $scope.topicCounter += 1
        if $scope.topicCounter < $scope.topicIds.length
            $scope.handleAdvanceToQuestion()
        else
            $scope.handleAdvanceToSummary()


    mock_load_questions = (callback) ->
        setTimeout(( ->
            questions = [{id: 0, index:3, question:"Is climate change happening?", possibleResponses:[{id:0,response:"Yes"},{id:1,response:"No"}]}, {id: 1, index:1, question:"Is immigration law working?", possibleResponses:[{id:2,response:"Yes"},{id:3,response:"No"}]},{id: 5, index:9, question:"What's your view on education in the US?", possibleResponses:[{id:9,response:"Education in the US could not be better"},{id:7,response:"Need more concentration on STEM"},{id:10,response:"We need to fund education less"}]}]
            callback(0, questions)
        ), 250)

    # Asynchronously load the list of questions for a topic
    # TODO: Replace with API call to server to grab data from DB
    mock_load_questions (topicId, questions) ->
        $scope.questions = questions.sort((u, v) -> u.index - v.index)
        $scope.currentTopic = "Testing"
        $scope.numQuestions = $scope.questions.length
        #TODO: Figure out how to persist state between forward and backward movement within form
        for question in $scope.questions
            for response in question.possibleResponses
                $scope.questionCheckModel[response.id] = false
        $scope.$apply()
)
