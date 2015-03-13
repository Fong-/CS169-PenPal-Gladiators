#= require ../spec_helper

describe "SurveyTopicsController", ->
    beforeEach ->
        @http.when("GET", "/api/v1/topics").respond([{
            name: "Climate",
            icon: "/fake/path",
            id: 1
        }]);
        @http.expectGET("/api/v1/topics")
        @controller("SurveyTopicsController", { $scope: @scope })
        @scope.topicSelectionModel = { 1: true, 2: false, 3: true, 4: true, 5: false, 6: true, 7: false, 8: false, 9: true, 10: false }
        @http.flush();

    it "should display 'Continue to Survey Questions' when the required number of topics is selected", ->
        expect(@scope.nextButtonValue()).toEqual("Continue to Survey Questions")
        @scope.topicSelectionModel[7] = true
        expect(@scope.nextButtonValue()).toEqual("Continue to Survey Questions")

    it "should display 'n More Topics to Continue' when more topics need to be selected", ->
        @scope.topicSelectionModel[1] = false
        expect(@scope.nextButtonValue()).toEqual("1 More Topic to Continue")
        @scope.topicSelectionModel[9] = false
        expect(@scope.nextButtonValue()).toEqual("2 More Topics to Continue")

    it "should disable the next button when more topics need to be selected", ->
        @scope.topicSelectionModel[1] = false
        expect(@scope.disableNextButton()).toEqual(true)

    it "should enable the next button when enough topics are selected", ->
        expect(@scope.disableNextButton()).toEqual(false)

    it "should update the model when topics are toggled", ->
        @scope.handleTopicToggled(1)
        expect(@scope.topicSelectionModel[1]).toEqual(false)
        @scope.handleTopicToggled(1)
        expect(@scope.topicSelectionModel[1]).toEqual(true)
