# CS169 PenPal Gladiators Iteration 1-1 Meeting
## 2015-03-04 10:10-11:00, 110MB Kresge Engineering Library
Members in Attendance: Nick, Wenson, Leo, Kevin, Lucas
Minutes by: Nick

Agenda:
- Repo Setup
- User Stories
- Code Design
- Code Style
- Next Steps

Meeting delayed.
Meeting called to session at 10:16 PDT.

## Repo Setup
All in attendance during vote vote for one repo.  4 in favor of one repo, 2 not present

##User Stories and Assigned Points
User Story | Assigned Points | Assigned Person(s)
-----------|-----------------|-------------------
1. Login | 1 | Lucas
2. Registration | 1 | Lucas
3. Survey frame | 1 | Wenson
4. Survey category checkboxes | 2 | Kevin, Bryan
5. Survey questions | 2 | Nick, Leo
6. Survey progress bar | 2 | Lucas
7. Survey summary page -- human-readable summary of survey responses | 2 | Wenson
8. Backend-Frontend Interface

Points | Mapping
-------|--------
n | Approximately n days of work

*Signup* process includes registration and survey.  *Registration* refers to the
username/password form.  *Survey* refers to the questionnaire that the user goes
through post-registration

##Code Design
No column limits.  Be smart.
Proper line endings.
### HTML
- Indent four spaces
- No script embedding
- Scripts at top of HTML
  - Jquery first, angular second

### Coffeescript
- Parentheses and commas with function calls
- CamelCase
- Double quotes for strings, but be smart (e.g. 'Are you a "?"')
- Single quotes for keys
- Indent four spaces
- CONSTANTS are all uppercase and snake_case
- Hash notation (`['-']`) for hashes, object notation (`.`) for objects
- Braces for hashes, arrays
- No commas for multiline hashes, arrays

- Wenson will investigate Coffeescript and Rails integration
- Kevin will figure out how to do `nonlocal` with Coffescript

## Code Design
- Table for next meeting

## Next Steps
- Skype meetings every ~3 days at 21:00 for ~10 minutes
- In-person meetings ~weekly Wednesday at 11:00 for < 1 hour

Meeting adjourned 11:29 PDT.

