# README

PROJECT'S TITLE: Online Voting System

ABSTRACT:
This is a online voting system where a user is invited to by his email and when invitation is accpeted the Voter gets registered on the system and he is considered eligible to vote in his constituency.

Now Voter has also got the right to apply for candidate ship which will be approved by the admin.

Here admin is the one holding all the powers, he can generate different polls which will triger the voting in all the constituencies.

ROLES:

* Admin
* Voter
* Candidate

FUNCTIONALITY:

* User Authentication using devise.
* User Authorization using pundit.
* Admin can invite users to the voting system.
* User can accept he invitation and signup.
* User can upload his profile (Cloudinary)
* Now user can generate candidate request.
* Admin can approve the candidate requests.
* Admin can create Polls.
* Votes can be casted by user in that poll.
* Results are announced once polling time is over.
* User can view the results

PROGRAMMING ENVIRONMENT:

* Frontend: HTML, CSS, CofeeCSS, Bootstrap

* Backend: Ruby on Rails

* Database: postgresql

COMPATIBLE VERSIONS:

* Ruby : 2.7
* Rails : 5.2.8
* Postgres : 14.5

INSTRUCTIONS:

1. Download the github repository voting-machine
2. Extract the file and copy voting-machine folder
3. Now use any development editor and open the folder ( Perfer VS Code)
4. Create a database.
5. Run bundle install so that all the dependencies are installed.
6. Run rails db:migrate so that all migrations are up.
7. Run rails server to start your local server.
8. Now go to 'localhost:3000' you interface will be their.
9. Use the Following Credential to log in as admin.
    Email: admin@gmail.com
    Password: 123456
10. Now you have all the access to manage users, polls, constituencies.


