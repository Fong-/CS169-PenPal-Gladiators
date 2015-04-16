@javascript @seed_topics
Feature: Allow user to keep track of their survey completion status by using a progress bar
    As a new user filling out the survey
    So that I can know how close I am to finishing
    I want to see my progress

Background: I am a new user
    Given the following questions exist:
        | text                          | topic           | index |
        | Opinion on climate changes?   | Climate         | 1     |
    And the following responses exist:
        | question_text                 | response_text                                     | index |
        | Opinion on climate changes?   | Climate change is happening.                      | 1     |

Scenario: Progress advances when a question is completed
    Given I am on the topic "Climate"
    When I answer a question
    Then the progress bar should be at 10%

Scenario: Check current progress
    Given I am on the topic "Education"
    And I answer all the questions
    Then the progress bar should be at 40%

Scenario: All questions answered
    Given I am on the topic "Philosophy"
    And I answer all the questions
    Then the progress bar should be at 100%
