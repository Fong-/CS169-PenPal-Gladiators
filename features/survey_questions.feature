Feature: Display survey questions so user can select answers. 
    
    As a User of Penpal Gladiators.
    So that I can be paired with another Gladiator of differing opinions.
    I want to fill out a survey.

Background: Questions have been added to database.
    
    Given the following responses exist:
        | response                                            |
        | Climate chage is happening.                         |
        | Climate chage is not happening.                     |
        | The current immigration law is adequate.            |
        | The current immigration law is not adequate.        |
        | Education should follow no child left behind.       |
        | Education should not follow no child left behind.   |
    
    Given the following questions exist:
        | question                         | responses   |
        | Opinions on climate chnages      | 1,2         |
        | Opinions on immigration laws     | 3,4         |
        | Opinions on education            | 5,6         |
 

Scenario: Display survey questions.
    Given I have selected "Education" for Survey Topic
    And I am on the survey questions page
    Then I should see "Opinions on education"
    Then I should see "Education should follow no child left behind."
    Then I should see "Education should not follow no child left behind."
    But I should not see "Opinions on climate changes"
    And I should not see "Climate change is happening."

Scenario: Select response for survey questions.
    Given I have selected "Education" for Survey Topic
    And I am on the survey questions page
    Then I should be able to check the response: "Education should follow no child left behind."
    


