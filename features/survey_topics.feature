@javascript @seed_topics
Feature: display a set of topic checkboxes
    As a excited gladiator
    So that I can select the discussion categories that I'm interested in
    I want to see topic checkboxes

Background: I am on the survey topic checkboxes page
    Given I am on the Survey Topic Checkboxes page

Scenario: can select topic checkboxes
    When I click topics "Education"
    Then the "Education" checkbox should be checked

Scenario: can unselect topic checkboxes
    When I click topics "Education"
    Then the "Education" checkbox should not be checked

Scenario: cannot proceed with less than 3 topics checked
    Given I click topics "Education", "Climate", "LGBT Rights"
    Then I should not see a button with "Continue to Survey Questions"
    And I should see a button with "2 More Topics to Continue"

Scenario: can proceed with 5 topics checked
    Given I click topics "Education", "Climate", "Philosophy", "Technology", "Religion"
    And I should see a button with "Continue to Survey Questions"


