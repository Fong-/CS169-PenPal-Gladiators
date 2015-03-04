Feature: Register
  As a new user
  I want to create an account.
  So that I can use PenPal Gladiators

Background:
    Given there is one existing username "foo@bar.com" in the database, and
the user is on the registration page.

Scenario: The new user registers using a new username and valid password.
    When the new user fills in the username form with username "gar@ply.com"
    When the new user fills in the password form with "fizzbuzz"
    And the new user clicks on "Create new account"
    Then the new user "gar@ply.com" with the SHA256 hash corresponding to "fizzbuzz" should appear in
      the database.
    And the user should be redirected to the profile page.

Scenario: The new user registers using an existing username.
    When the new user fills in the username form with username "foo@bar.com"
    When the new user fills in the password form with the password "fizzbuzz"
    And the new user clicks on "Create new account"
    Then the user should be redirected to the registration page.
    And an error message should flash indicating that the username is taken.

Scenario: The new user registers using an invalid username.
    When the new user fills in the username form with username "$h!t_gar-ply_com"
    When the new user fills in the password form with the password "fizzbuzz"
    And the new user clicks on "Create new account"
    Then the user should be redirected to the registration page.
    And an error message should flash indicating invalid username.

Scenario: The new user registers using an invalid password.
    When the new user fills in the username form with username "gar@ply.com"
    When the new user fills in the password form with the password ""
    And the new user clicks on "Create new account"
    Then the user should be redirected to the registration page.
    And an error message should flash indicating invalid password length.