Feature: Allow user to keep track of their survey completion status by using a progress bar
    As a new user filling out the survey
    So that I can know how close I am to finishing
    I want to see my progress

Background: I am a new user
    Given the database is set up
    And I am a new user
    And I am filling out the survey
    And I have selected 5 topics
    And I have selected "Education" for Survey Topic

Scenario: Progress on the current topic tab advances when a question is filled
    Given I am on the survey questions page
    When I check a response box
    Then I should see my progress bar tick forward
    And I should see my progress percentage go up

Scenario: Progress on the current topic tab goes back when a box is unchecked
    Given I am on the survey questions page
    When I uncheck a response box
    Then I should see my progress bar tick backward
    And I should see my progress percentage go down

Scenario: Check current progress
    Given I am on the survey questions page
    And I have finished 1 topic
    Then I should see 20% progress

Scenario: All questions answered
    Given I am on the survey questions page
    And I have finished 5 topics
    Then I should see 100% progress
