Feature: Display survey questions so user can select answers.

    As a User of Penpal Gladiators.
    So that I can be paired with another Gladiator of differing opinions.
    I want to fill out a survey.

Background: Questions have been added to database.
    Given the following questions exist:
        | text                          | index |
        | Opinion on climate changes?   | 1     |
        | Opinion on immigration laws?  | 2     |
        | Opinions on education?        | 3     |
    And the following responses exist:
        | question_text                 | response_text                                     | index |
        | Opinion on climate changes?   | Climate change is happening.                      | 1     |
        | Opinion on climate changes?   | Climate change is not happening.                  | 2     |
        | Opinion on immigration laws?  | The current immigration law is adequate.          | 1     |
        | Opinion on immigration laws?  | The current immigration law is not adequate.      | 2     |
        | Opinions on education?        | Education should follow no child left behind.     | 1     |
        | Opinions on education?        | Education should not follow no child left behind. | 2     |
    And I am on the first survey questions page

Scenario: Display survey questions.
    Given I have selected "Education" for Survey Topic
    And I am on the survey questions page
    Then I should see Opinions on education
    Then I should see Education should follow no child left behind.
    Then I should see Education should not follow no child left behind.
    But I should not see Opinions on climate changes
    And I should not see Climate change is happening.

Scenario: Select response for survey questions.
    Given I have selected "Education" for Survey Topic
    And I am on the survey questions page
    Then I should be able to check the response: "Education should follow no child left behind."



