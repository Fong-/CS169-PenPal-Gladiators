progressBar = angular.module("ProgressBar", ["StartPageServices"])

progressBar.controller("ProgressBarController", ["$scope", "StartPageStateData", ($scope, StartPageStateData) ->
    percentComplete = 0

    $scope.percentComplete = () ->
        numSelectedTopics = StartPageStateData.selectedTopics.length
        numTopicsCompleted = StartPageStateData.progress.numTopicsCompleted
        numQuestions = StartPageStateData.progress.numQuestions
        numQuestionsCompleted = StartPageStateData.progress.numQuestionsCompleted

        topicPercent = numTopicsCompleted / numSelectedTopics
        questionPercent = numQuestionsCompleted / numQuestions

        percentPerTopic = 1 / numSelectedTopics
        topicPercentBuffer = 0.1 * percentPerTopic

        console.log "======"
        console.log numTopicsCompleted
        console.log numSelectedTopics
        # console.log numQuestionsCompleted
        # console.log numQuestions
        # console.log topicPercent
        # console.log questionPercent

        if numQuestions is 0
            console.log "here1"
            console.log topicPercent * 100
            return topicPercent * 100
        else
            console.log "here2"
            console.log (topicPercent + (percentPerTopic - topicPercentBuffer) * questionPercent) * 100
            return (topicPercent + (percentPerTopic - topicPercentBuffer) * questionPercent) * 100
])
