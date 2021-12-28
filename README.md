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
7. Allow logged-in users to view and rotate their API key.
8. Allow users to check all events, a specific event, update/destroy an event that he/she has created, register and deregister an event that another user has created through API end points.


## API Endpoints Application
### Before you start using the API end points, get a private API key in your user edit page. Under the button Update, there's a text box next to the button "Generate New Key", copy the API key from the text box and save it somewhere.
### API Endpoints Details
|HTTP Verb     |url                            | Explanation                 |Remarks
| :---         |  :---:                        |  :---:                      |  :---:                                                                 |
|GET           |/api/v1/events                |Display all events            |
|POST          |/api/v1/events                |Create a new event            |provide event_date (as datetime) and location (as string)
|GET           |/api/v1/events/:id            |Show an event                 |
|PATCH         |/api/v1/events/:id            |Edit an event                 |If you are not the creator of the event, a 401 status code will be returned. Provide a new event_date or location.|                                                                   
|PUT           |/api/v1/events/:id            |Edit an event           |If you are not the creator of the event, a 401 status code will be returned. Provide a new event_date and a new location.|
|DELETE        |/api/v1/events/:id            |Delete an event         |If you are not the creator of the event, a 401 status code will be returned.
|GET           |/api/v1/events/:id/attendees  |Show attendees of an event  
|POST          |/api/v1/events/:id/register   |Register an event       |For the action to be successful, the event has to be created by another user, and you have not registered for the event yet. Otherwise, a 403 status code with an error message will be returned.
|POST          |/api/v1/events/:id/deregister |Deregister an event     |For the action to be successful, the event has to be created by another user, and you have   already registered for the event. Otherwise, a 403 status code with an error message will be returned.
|GET           |/api/v1/users/:id             |Show a user
|PATCH         |/api/v1/users/:id             |Edit a user             |If the User Id you provided is not your own user Id, a 401 status code will be returned. 
|PUT           |/api/v1/users/:id             |Edit a user             |If the User Id you provided is not your own user Id, a 401 status code will be returned.
|GET           |/api/v1/users/:id/events      |Display registered events |If the User Id you provided is not your own user ID, a 401 status code will be returned.
|GET           |/api/v1/users/:id/created_events |Display created events |A list of events which were created by the user, with a list of attendees, will be displayed. If the User Id you provided is not your own user ID, a 401 status code will be returned.







## Todo List:
1. To make logged-in user select if their created events should be private, meaning only selected users can register.
2. Add confirmable and recoverable features of devise gem.
