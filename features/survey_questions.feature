@javascript @seed_topics
Feature: Display survey questions so user can select answers.

    As a User of Penpal Gladiators.
    So that I can be paired with another Gladiator of differing opinions.
    I want to fill out a survey.

Background: Questions have been added to database.
    Given the following questions exist:
        | text                          | topic           | index |
        | Opinion on climate changes?   | Climate         | 1     |
        | Opinion on immigration laws?  | Immigration Law | 2     |
        | Opinions on education?        | Education       | 3     |
    And the following responses exist:
        | question_text                 | response_text                                     | index |
        | Opinion on climate changes?   | Climate change is happening.                      | 1     |
        | Opinion on climate changes?   | Climate change is not happening.                  | 2     |
        | Opinion on immigration laws?  | The current immigration law is adequate.          | 1     |
        | Opinion on immigration laws?  | The current immigration law is not adequate.      | 2     |
        | Opinions on education?        | Education should follow no child left behind.     | 1     |
        | Opinions on education?        | Education should not follow no child left behind. | 2     |
    And I have selected the topics "Education", "Climate", "Philosophy", "Technology", "Religion"

Scenario: Display the correct survey questions.
    Given I have navigated to the first survey questions page
    Then I should see "Opinion on climate changes?"
    Then I should see "Climate change is happening."
    Then I should see "Climate change is not happening."
    But I should not see "Opinion on immigration laws?"
    And I should not see "Opinions on education?"
    And I should not see "The current immigration law is adequate."
    And I should not see "The current immigration law is not adequate."
    And I should not see "Education should follow no child left behind."
    And I should not see "Education should not follow no child left behind."

Scenario: Cannot move on without answering all questions.
    Given I have navigated to the first survey questions page
    Then I should see a button with "1 Unanswered Questions"
    But I should not see a button with "Next"

Scenario: Can move on after answering all questions.
    Given I have navigated to the first survey questions page
    And I answer all the questions
    Then I should see a button with "Next"



