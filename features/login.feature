Feature: Login
    As a new user
    I want to log in to an existing account
    So that I can use PenPal Gladiators.

Background:
    Given there is one and only one user "foo@bar.com" with password "fizzbuzz" in the database.

Scenario: The user logs in with the correct username and password.
    When the user fills in the username form with username "foo@bar.com"
    When the new user fills in the password form with "fizzbuzz"
    And the new user clicks on "Login"
    Then the user should be redirected to the profile page.

Scenario: The user logs in with the incorrect username and password.
    When the user fills in the username form with username "foo@bar.com"
    When the new user fills in the password form with "buzz"
    And the new user clicks on "Login"
    Then an error should flash notifying the user of a bad password.

Scenario: The user logs in with the correct username and password.
    When the user fills in the username form with username "hi@bar.com"
    When the new user fills in the password form with "fizzbuzz"
    And the new user clicks on "Login"
    Then an error should flash notifying the user of an nonexistant user and inviting the user to register.

Scenario: The user attempts a SQL injection.
    When the user fills in the username form with a SQL query "; DROP * FROM users;"
    When the new user fills in the password form with "; DROP * FROM users;"
    And the new user clicks on "Login"
    Then the user should be presented with a page saying "Nice try! Didn't work."