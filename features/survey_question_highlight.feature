@javascript @seed_topics
Feature: The first unanswered question should be highlighted (surround by a yellow box) in the survey question page
    As a new user filling out the survey
    So that I can finish the survey easier
    I want to be able to easily find the next question to answer

Background: I am a new user
    Given the following questions exist:
        | text                          | topic           | index |
        | Q1                            | Climate         | 1     |
        | Q2                            | Climate         | 2     |
        | Q3                            | Climate         | 3     |
        | Q4                            | Climate         | 4     |
        | Opinion on education?         | Education       | 1     |
        | Opinion on economy?           | Economy         | 1     |
        | Opinion on technology?        | Technology      | 1     |
        | Opinion on LGBT Rights?       | LGBT Rights     | 1     |
    And the following responses exist:
        | question_text                | response_text                                     | index | summary_text |
        | Q1                           | Climate change is happening.                      | 1     | I believe climate change is happening. |
        | Q1                           | Climate change is not happening.                  | 2     | I don't believe climate change is happening. |
        | Q2                           | Climate change is happening.                      | 1     | I believe climate change is happening. |
        | Q2                           | Climate change is not happening.                  | 2     | I don't believe climate change is happening. |
        | Q3                           | Climate change is happening.                      | 1     | I believe climate change is happening. |
        | Q3                           | Climate change is not happening.                  | 2     | I don't believe climate change is happening. |
        | Q4                           | Climate change is happening.                      | 1     | I believe climate change is happening. |
        | Q4                           | Climate change is not happening.                  | 2     | I don't believe climate change is happening. |
        | Opinion on education?        | Education should follow no child left behind.     | 1     | I believe education should follow no child left behind. |
        | Opinion on education?        | Education should not follow no child left behind. | 2     | I believe education should not follow no child left behind. |
        | Opinion on economy?          | Obama destroys our economy.                       | 1     | I believe Obama destroyed our economy. |
        | Opinion on economy?          | Obama didn't destroys our economy.                | 2     | I don't believe Obama destroyed our economy. |
        | Opinion on technology?       | Technology will solve all our problems.           | 1     | I believe technology will solve all the problems. |
        | Opinion on technology?       | Technology will not solve all our problems.       | 2     | I don't believe technology will solve all the problems. |
        | Opinion on LGBT Rights?      | LGBT rights should be protected.                  | 1     | I believe LGBT should have the same rights as everyone else. |
        | Opinion on LGBT Rights?      | LGBT rights should not be protected.              | 2     | I don't believe LGBT should have the same rights as everyone else. |
    And I am on the Survey Topic Checkboxes page
    And I click topics "Climate", "Education", "Economy", "Technology", "LGBT Rights"

# Assuming the question page have 4 questions total
Scenario: First question is highlighted when every question is unanswered
    Given I have navigated to the first survey questions page
    Then I should see question 1 highlighted
    And I should not see question 2 highlighted

Scenario: When a highlighted question is answered, it becomes unhighlighted and the next unanswered question is highlighted
    Given I have navigated to the first survey questions page
    Then I should see question 1 highlighted
    And I select response 1 for question 1
    Then I should not see question 1 highlighted
    And I should see question 2 highlighted

Scenario: No question is highlighted when every question is answered
    Given I have navigated to the first survey questions page
    And I select response 1 for every question
    Then I should not see any question highlighted

Scenario: First question is still highlighted after questions below are answered
    Given I have navigated to the first survey questions page
    And I select response 1 for question 2
    Then I should see question 1 highlighted
    And I select response 1 for question 3
    Then I should see question 1 highlighted
    And I select response 1 for question 4
    Then I should see question 1 highlighted

Scenario: The highlight jumps to the next unanswered question when the highlighted question is answered
    Given I have navigated to the first survey questions page
    Then I should see question 1 highlighted
    And I select response 1 for question 2
    Then I should see question 1 highlighted
    And I select response 1 for question 3
    Then I should see question 1 highlighted
    And I select response 1 for question 1
    Then I should not see question 1 highlighted
    And I should see question 4 highlighted
