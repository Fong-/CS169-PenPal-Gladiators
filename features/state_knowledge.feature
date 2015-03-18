Feature: User inputs should persist throughout the survey, and user should be able to go back and edit them
    As a new user to Penpal Gladiators
    So that I don't have to worry about making mistakes on the survey
    I want to be able to go back and edit my survey responses

Background: I am a new user
    Given the database is setup
    And I am starting a survey

Scenario: Correct message is displayed when going back to topic selection page
    Given I selected five topics
    Then I should see "Select five topics"
    When I pressed the next button
    And I pressed the back button
    Then I should see "Edit and press Next button to save changes"

Scenario: Correct message is displayed when going back to survey question page
    Given I selected five topics
    When I pressed the next button
    Then I should see "Answer the following"
    When I selected the first responses for each question
    And I pressed the next button
    And I pressed the back button
    Then I should see "Edit and press Next button to save changes"