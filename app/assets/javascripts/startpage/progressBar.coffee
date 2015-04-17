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

        if numQuestions is 0
            return topicPercent * 100
        else
            return (topicPercent + (percentPerTopic - topicPercentBuffer) * questionPercent) * 100
])
