@javascript @seed_topics
Feature: Display summary for user responses and user to edit their responses
    As a new user who just finished the survey
    So that I can check my answers
    I want to verify my answers and fix them if needed

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

Scenario: A summary of the user responses is displayed
    Given I have navigated to the summary page
    Then I should see "Climate"
    And I should see "I believe climate change is happening"
    And I should see "Education"
    And I should see "I believe education should follow no child left behind"
    And I should see "Economy"
    And I should see "I believe Obama destroyed our economy"
    And I should see "Technology"
    And I should see "I believe technology will solve all the problems"
    And I should see "LGBT Rights"
    And I should see "I believe LGBT should have the same rights as everyone else"

Scenario: Separate page for editing responses to survey questions
    Given I have navigated to the summary page
    And I click on the edit button for topic "Education"
    Then I should see "Opinion on education?"
    And I should see "Education should follow no child left behind."
    And I should see "Education should not follow no child left behind."
    And I should see "Edit responses and return to summary to complete registration"
    And I should see a button with "Save changes and return to Summary"
    And I should not see a button with "Back"

Scenario: Edit responses to survey questions
    Given I have navigated to the summary page
    And I click on the edit button for topic "Education"
    And I select response 2 for question 1
    And I press "Save changes and return to Summary"
    Then I should see "I believe education should not follow no child left behind."
    And I should not see "I believe education should follow no child left behind."
