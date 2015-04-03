Feature: Allow user to keep track of their survey completion status by using a progress bar
    As a new user filling out the survey
    So that I can know how close I am to finishing
    I want to see my progress

Background: I am a new user
    Given the database is setup
    Given I have selected the topics "Education"

Scenario: Progress on the current topic tab advances when a question is filled
    Given I am on the survey questions page
    When I check a response
    Then the progress bar should move forward
    And the progress bar should not move backward

Scenario: Progress on the current topic tab goes back when a box is unchecked
    Given I am on the survey questions page
    When I uncheck a response
    Then the progress bar should move backward

Scenario: Check current progress
    Given I am on the survey questions page
    And I answer all the questions
    Then the progress bar should be full

Scenario: All questions answered
    Given I am on the survey questions page
    And I have finished 1 topics
    Then the progress bar should be full
