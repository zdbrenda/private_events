# Private Events (A simple Eventbrite clone done in Ruby on Rails)

This projetc is a part of the curriculum of the Odin Project (https://www.theodinproject.com/). I use it mainly to practice using Ruby on Rails to develop Web Applications.

The project description is here: https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-on-rails/lessons/private-events

I have also deployed it to Heroku: https://shrouded-bayou-01447.herokuapp.com/


## The main features I have implemented so far include:

1. Allow users to login and sign up from devise gem (https://github.com/heartcombo/devise).
2. Allow logged-in users to create new events.
3. Allow logged-in users to register/deregister events that are created by other users.
4. Allow logged-in users to edit/destroy future events that are created by themselves.
5. Allow logged-in users to see events they have registered.
6. Allow users to log in through Github and Google.

## Todo List:
1. To make logged-in user select if their created events should be private, meaning only selected users can register.
2. Add confirmable and recoverable features of devise gem.
