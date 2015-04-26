@javascript
Feature: allow the user to logout
    As a registered gladiator
    So that I can prevent others from using my account when I am away from my computer
    I want to be able to logout

Background: I am a registered gladiator who is logged in already
    Given I sign in as "foo@bar.com" with password "fizzbuzz"

Scenario: can logout
    Given I navigate to the login page
    Then I should be on the home page     # redirect since user is logged in
    When I click on the logout button
    Then I should be on the login page
    When I navigate to the home page
    Then I should be on the login page    # redirect since user is not logged in
    When I navigate to the login page
    Then I should be on the login page    # should not redirect since user is not logged in
