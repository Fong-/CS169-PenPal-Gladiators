Feature: survey frame
As a new user
So that I can make my preferences known
I want to advance through survey views.

Background: a new user has registered using an email and a password and is advancing through the survey pipeline.

Scenario: a new user can navigate from registration to topic checkboxes.
Steps:
    When the new user follows "Next" from registration..
    Then the new user should see "Next" and "Previous" buttons.

Scenario: a new user can navigate from topic checkboxes to registration.
Steps:
    When the new user follows "Previous" from topic checkboxes.
    Then the new user should see the "Next" button.

Scenario: a new user can navigate from topic checkboxes to questions.
Steps:
    When the new user follows "Next" from topic checkboxes.
    Then the new user should see "Next" and "Previous" buttons.

Scenario: a new user can navigate from questions to topic checkboxes.
Steps:
    When the new user follows "Previous" from questions.
    Then the new user should see "Next" and "Previous" buttons.

Scenario: a new user can navigate from questions to summary.
Steps:
    When the new user follows "Next" from questions.
    Then the new user should see the "Previous" button.

Scenario: a new user can navigate from summary to questions.
Steps:
    When the new user follows "Previous" from summary.
    Then the new user should see "Next" and "Previous" buttons.
