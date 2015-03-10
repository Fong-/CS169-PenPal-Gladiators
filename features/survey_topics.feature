Feature: display a set of topic checkboxes

    As a excited gladiator
    So that I can select the discussion categories that I'm interested in
    I want to see topic checkboxes

Background: I am on the survey topic checkboxes page
    
    Given I am on the "Survey Topic Checkboxes" page

Scenario: select topic checkboxes
    When I check "Education"
    Then the "Education" checkbox should be checked

Scenario: cannot proceed with less than 3 topics checked
    Given I check "2" topics
    Then I should not see "Next"
    And I should see "Select 1 more to continue"

Scenario: can proceed with 3 topics checked
    Given I check "3" topics
    Then I should see "Next"

Scenario: cannot select more than 5 topics
    Given I check "5" topics
    Then unchecked checkboxes should be disabled
    