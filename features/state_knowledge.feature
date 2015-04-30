@javascript @seed_topics
Feature: User inputs should persist throughout the survey, and user should be able to go back and edit them
    As a new user to Penpal Gladiators
    So that I don't have to worry about making mistakes on the survey
    I want to be able to go back and edit my survey responses

Background: Questions have been added to database.
    Given the following questions exist:
        | text                          | topic           | index |
        | Opinion on climate changes?   | Climate         | 1     |
        | Opinion on education?         | Education       | 1     |
        | Opinion on economy?           | Economy         | 1     |
        | Opinion on technology?        | Technology      | 1     |
        | Opinion on LGBT Rights?       | LGBT Rights     | 1     |
    And the following responses exist:
        | question_text                | response_text                                     | index | summary_text |
        | Opinion on climate changes?  | Climate change is happening.                      | 1     | I believe climate change is happening. |
        | Opinion on climate changes?  | Climate change is not happening.                  | 2     | I don't believe climate change is happening. |
        | Opinion on education?        | Education should follow no child left behind.     | 1     | I believe education should follow no child left behind. |
        | Opinion on education?        | Education should not follow no child left behind. | 2     | I believe education should not follow no child left behind. |
        | Opinion on economy?          | Obama destroys our economy.                       | 1     | I believe Obama destroyed our economy. |
        | Opinion on economy?          | Obama didn't destroys our economy.                | 2     | I don't believe Obama destroyed our economy. |
        | Opinion on technology?       | Technology will solve all our problems.           | 1     | I believe technology will solve all the problems. |
        | Opinion on technology?       | Technology will not solve all our problems.       | 2     | I don't believe technology will solve all the problems. |
        | Opinion on LGBT Rights?      | LGBT rights should be protected.                  | 1     | I believe LGBT should have the same rights as everyone else. |
        | Opinion on LGBT Rights?      | LGBT rights should not be protected.              | 2     | I don't believe LGBT should have the same rights as everyone else. |

Scenario: Correct message is displayed when going back to topic selection page
    Given I am on the Survey Topic Checkboxes page
    Then I should see "Pick at least 5 topics"
    When I click topics "Climate", "Education", "Economy", "Technology", "LGBT Rights"
    And I press "Continue to Survey Questions"
    And I press "Back"
    Then I should see "Edit selections and press Next to continue"

Scenario: Correct message is displayed when going back to survey question page
    Given I am on the Survey Topic Checkboxes page
    When I click topics "Climate", "Education", "Economy", "Technology", "LGBT Rights"
    And I press "Continue to Survey Questions"
    Then I should see "Answer the following"
    When I select response 1 for every question
    And I press "Next"
    And I wait 1 second
    And I press "Back"
    Then I should see "Edit responses and press Next to continue"
