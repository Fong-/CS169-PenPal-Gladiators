Feature: allow the user to navigate the site using the navigation bar
    As a registered gladiator
    So that I can access parts of the site more efficiently
    I want to use the navigation bar

Background: I am a registered gladiator who is navigating the site
    Given a user with email "foo@bar.com" and password "fizzbuzz" in the database
    Given the user "foo@bar.com" is signed in
    Given the user is on the home page

Scenario: can navigate to the profile page and back
    Given I am on the homepage
    When I follow "Profile"
    I should be on the profile page
    When I follow "Home"
    I should be on the home page

Scenario: can navigate to the home page and back
    Given I am on the profile page
    When I follow "Home"
    I should be on the home page
    When I follow "Profile"
    I should be on the profile page
