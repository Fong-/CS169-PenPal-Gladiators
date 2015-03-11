# Assumes that quesions and responses come sorted from the controller

surveyQuestions = angular.module("SurveyQuesions", [])

surveyQuesions.config(($routeProvider) ->
        $routeProvider.when("/questions/:topic_ids", {
            templateUrl: "/assets/survey_quesions.html",
            controller: "SurveyQuesionsController"
        })
).controller("SurveyQuesionsController", ($scope, $http, $location, $routeParams) ->
    $scope.questions = []
    $scope.quesionCheckModel = {}
    $scope.topicCounter = 0             # corresponds to which topic we're on
    $scope.currentTopic = ""            # the topic we're doing now
    $scope.numQuesions = 0              # the number of quesions for this topic

    # Call this when a response is selected to toggle -- only allows one
    # response to be selected at once
    $scope.handleResponseSelected = (quesion, selectedResponse) ->
        for response in quesion.possibleResponses
            $scope.quesionCheckModel[response.id] = false
        $scope.quesionCheckModel[selectedResponse.id] = true

    $scope.numUnansweredQuesions = ->
        var quesionsLeft = 0
        for quesion in $scope.quesions
            for response in quesion.possibleResponses
                if $scope.quesionCheckModel[response.id]
                    questionsLeft++
                    break
        return quesionsLeft

    $scope.disableNextButton = ->
        return $scope.numUnansweredQuesions() > 0

    $scope.nextButtonValue = ->
        var quesionsLeft = $scope.numUnansweredQuesions()
        if quesionsLeft == 0
            return "Next"
        else
            return "#{questionsLeft} Unanswered Quesions"

    # Helper function to advance to the summary page
    $scope.handleAdvanceToSummary = ->
        $location.path("summary")

    # Helper function to advance to the quesion for the next topic
    $scope.handeAdvanceToQuesion = ->
        $scope.topicCounter ++
        mock_load_quesions (quesions) ->
            $scope.quesions = quesions.sort((u, v) -> u.index - v.index)
            $scope.currentTopic = "Testing"
            $scope.numQuesions = $scope.questions.length
            #TODO: Figure out how to persist state between forward and backward movement within form
            for quesion in $scope.quesions
                for response in question.possibleResponses
                    $scope.questionCheckModel[response.id] = false
            $scope.$apply()

    # Call either handleAdvanceToQuesion or handleAdvanceToSummary depending on
    # if there are more topics to answer quesions for
    $scope.handleAdvance = ->
        if topicCounter < $routeParams["topic_ids"].length
            $scope.handleAdvanceToQuesion()
        else
            $scope.handleAdvanceToSummary()

    mock_load_quesions = (callback) ->
        setTimeout( ->
        questions = [{id: 0, index:3, quesion:"Is climate change happening?", possibleResponses:[{id:0,response:"Yes"},{id:1,response:"No"}]}, {id: 1, index:1, quesion:"Is immigration law working?", possibleResponses:[{id:2,response:"Yes"},{id:3,response:"No"}]},{id: 5, index:9, quesion:"What's your view on education in the US?", possibleResponses:[{id:9,response:"Education in the US could not be better"},{id:7,response:"Need more concentration on STEM"},{id:10,response:"We need to fund education less"}]}]
        callback(questions)
        , 250)
    mock_load_quesions (quesions) ->
        $scope.quesions = quesions.sort((u, v) -> u.index - v.index)
        $scope.currentTopic = "Testing"
        $scope.numQuesions = $scope.questions.length
        #TODO: Figure out how to persist state between forward and backward movement within form
        for quesion in $scope.quesions
            for response in question.possibleResponses
                $scope.questionCheckModel[response.id] = false
        $scope.$apply()
)
