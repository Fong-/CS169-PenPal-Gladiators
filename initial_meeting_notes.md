### What problem is PenPal Gladiators trying to solve?

- People are turned off by the usual online spaces.
- We want to match people together with differing political opinions.

### Who does PenPal Gladiators target?

- People with differing but moderate political opinions who want to discuss divisive issues in a civil, constructive manner.


### Will PenPal gladiators consist of a major set of features, or multiple independent sets of features designed to solve different problems?

- One major set of features. Any more would bring the project out of the scope of one semester.

### What are the big features in PenPal Gladiators?

First, the user should be able to register on our site.
```
Feature: landing page
As a new user
  So that I want to use PenPal Gladiators
  I want to create an account.

Background: There is one existing username "foo@bar.com" in the database, and
the user is on the registration page.

Scenario: The new user registers using a new username and valid password.
Steps:
    - When the new user fills in the username form with username "gar@ply.com"
    - When the new user fills in the password form with the password "fizzbuzz"
    - And the new user clicks on "Create new account"
    - Then the new user "gar@ply.com" with password "fizzbuzz" should appear in
      the database.
    - And the user should be redirected to the profile page.

Scenario: The new user registers using an existing username.
Steps:
    - When the new user fills in the username form with username "foo@bar.com"
    - When the new user fills in the password form with the password "fizzbuzz"
    - And the new user clicks on "Create new account"
    - Then the user should be redirected to the registration page.
    - And an error message should flash indicating that the username is taken.

Scenario: The new user registers using an invalid username.
Steps:
    - When the new user fills in the username form with username "gar-ply_com"
    - When the new user fills in the password form with the password "fizzbuzz"
    - And the new user clicks on "Create new account"
    - Then the user should be redirected to the registration page.
    - And an error message should flash indicating invalid username.

Scenario: The new user registers using an invalid password.
Steps:
    - When the new user fills in the username form with username "gar@ply.com"
    - When the new user fills in the password form with the password "hi"
    - And the new user clicks on "Create new account"
    - Then the user should be redirected to the registration page.
    - And an error message should flash indicating invalid password length.
```

Second, if the user has already registered, he/she should be able to log in automatically just by visiting the URL.
```
Feature: automatic login
As an existing user
  So that I want to use PenPal Gladiators quickly
  I want to log in automatically.

Background: There is one existing username "foo@bar.com" in the database, and
a user visits our website.

Scenario: The user's username is "foo@bar.com"
Steps:
    - When the user submits his/her cookies to the server.
    - Then the user should be redirected to the profile page of "foo@bar.com".
    - And the user should be authenticated as "foo@bar.com"
```

`TODO` We need a feature that allows us to extract information from the user -- in particular, their stands on divisive issues such as climate change, health care, etc. I didn't write this feature yet, since it's not obvious what the best way to decompose this into many steps is.

`TODO` We need a feature that allows us to match users that have differing opinions about the same divisive issues in a way that is "optimal" for all users. Refer to stable marriage for ideas on where to start; however, our needs for PenPal Gladiators will be different in several ways: users may be matched multiple times (not just once, as in SMP) and our set of users will constantly change, so the optimal matching at one moment in time may not still be optimal when new users are introduced.

`TODO` We need a feature that allows pairs of matched users to both contribute to a number of threads, each regarding a particular topic/subject such as climate change, abortion, etc.

`TODO` We need a feature that allows pairs of matched users to close off a conversation thread when the users have reached a consensus regarding the subject of that thread. Either user may edit and post a statement resolving the discussion thread, and the other user may mark the statement as accepted, archiving the thread.

### When and how often should we meet?

- Every two weeks.
- 11:00 on Fridays at 2538 Channing Way.

### How do we deal with those who troll, intentionally hurt others, etc.?

- Implement some form of algorithmic moderation (stretch goal).

### Is it going to be more like a forum or chatroom? Or both?

- It should have elements of both.
- Users should be able to post regardless of whether or not their debate partner is actively using the app.
- If both people are using the app, it should feel like a chat system (e.g. you should be able to see that the other is currently writing something).
- See the Facebook messages system.