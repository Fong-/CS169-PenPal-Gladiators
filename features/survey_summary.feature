Feature: Display summary for user responses and user to edit their responses
    As a new user who just finished the survey
    So that I can check my answers
    I want to verify my answers and fix them if needed

Background: I am on the summary
    Given the database is setup
    And I am a new user
    And I filled out the survey

Scenario: A summary of the user responses is displayed
    Given I am on the summary page
    Then I should see the responses I selected displayed

Scenario: Separate page for editing responses to survey questions
    Given I am on the summary page
    And I click on the edit button for "Education"
    Then I should be on the "Education" question page
    And I should see "Edit and press 'Return to Summary' to save changes"

Scenario: Edit responses to survey questions
    Given I am on the summary page
    And I click on the edit button for "Education"
    And I select response 2 for question 1
    And I press "Return to Summary"
    Then I should be on the summary page
    And I should see response 2 for question 1
