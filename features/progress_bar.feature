Feature: Allow user to keep track of their survey completion status by using a progress bar
    As a new user filling out the survey
    So that I can know how close I am to finishing
    I want to see my progress

Background: I am a new user
    Given I have selected the topics "Education", "Climate", "Philosophy", "Technology", "Religion"

Scenario: Progress advances when a question is filled
    Given I am on the survey questions page
    And I am on topic ID 1
    When I check a response
    Then the progress bar should be at 10%
    And I check a response
    Then the progress bar should be at 20%

Scenario: Check current progress
    Given I am on the survey questions page
    And I am on topic ID 2
    And I answer all the questions
    Then the progress bar should be at 40%

Scenario: All questions answered
    Given I am on the survey questions page
    And I am on topic ID 9
    And I answer all the questions
    Then the progress bar should be at 100%
