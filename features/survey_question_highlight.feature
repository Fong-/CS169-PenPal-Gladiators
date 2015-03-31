Feature: The first unanswered question should be highlighted (surround by a yellow box) in the survey question page
    As a new user filling out the survey
    So that I can finish the survey easier
    I want to be able to easily find the next question to answer

Background: I am a new user
    Given the database is setup
    And I am a new user
    And I selected five topics
    And I press "next"

# Assuming the question page have 4 questions total
Scenario: First question is highlighted when every question is unanswered
    Given I am on a survey questions page
    Then I should see question 1 highlighted

Scenario: When a highlighted question is answered, it becomes unhighlighted and the next unanswered question is highlighted
    Given I am on a survey questions page
    Then I should see question 1 highlighted
    And I select response 1 for question 1
    Then I should not see question 1 highlighted
    And I should see question 2 highlighted

Scenario: No question is highlighted when every question is answered
    Given I am on a survey questions page
    And I select response 1 for every question
    Then I should not see any question highlighted

Scenario: First question is still highlighted after questions below are answered
    Given I am on a survey questions page
    And I select response 1 for question 2
    Then I should see question 1 highlighted
    And I select response 1 for question 3
    Then I should see question 1 highlighted
    And I select response 1 for question 4
    Then I should see question 1 highlighted

Scenario: The highlight jumps to the next unanswered question when the highlighted question is answered
    Given I am on a survey questions page
    Then I should see question 1 highlighted
    And I select response 1 for question 2
    Then I should see question 1 highlighted
    And I select response 1 for question 3
    Then I should see question 1 highlighted
    And I select response 1 for question 1
    Then I should not see question 1 highlighted
    And I should see question 4 highlighted
