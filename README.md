# Putting it All Together: Client-Server Communication

## Learning Goals

- Understand how to communicate between client and server using fetch, and how
  the server will process the request based on the URL, HTTP verb, and request
  body
- Debug common problems that occur as part of the request-response cycle

## Introduction

Just like the last lesson, we've got code for a React frontend and Rails API
backend set up. This time though, it's up to you to use your debugging skills to
find and fix the errors!

To get the backend set up, run:

```console
$ bundle install
$ rails db:migrate db:seed
$ rails s
```

Then, in a new terminal, run the frontend:

```console
$ npm install --prefix client
$ npm start --prefix client
```

Confirm both applications are up and running by visiting
[`localhost:4000`](http://localhost:4000) and viewing the list of toys in your
React application.

## Deliverables

In this application, we have the following features:

- Display a list of all the toys
- Add a new toy when the toy form is submitted
- Update the number of likes for a toy
- Donate a toy to Goodwill (and delete it from our database)

The code is in place for all these features on our frontend, but there are some
problems with our API! We're able to display all the toys, but the other three
features are broken.

Use your debugging tools to find and fix these issues.

There are no tests for this lesson, so you'll need to do your debugging in the
browser and using the Rails server logs and `byebug`.

**Note**: You shouldn't need to modify any of the React code to get the
application working. You should only need to change the code for the Rails API.

As you work on debugging these issues, use the space in this README file to take
notes about your debugging process. Being a strong debugger is all about
developing a process, and it's helpful to document your steps as part of
developing your own process.

## Your Notes Here

- Add a new toy when the toy form is submitted

  - How I debugged:
  1. Using the new toy form, add a New Toy using the form
  2. Inspect the network tab to monitor the response from the post request
  3. Returns status code of 500 => internal error => check Rails console log
  4. NameError (uninitialized constant ToysController::Toys)
  5. Typo made in class definition needs to be changed

- Update the number of likes for a toy

  - How I debugged:
  1. Add a like to the toy, monitor network tab for response
  2. Liking crashes the application, error given by React: Unexpected end of JSON input
  3. Check rails console log => 'Unpermitted parameter: :id'
  4. We want to accesss the ID, however we want to keep this outside of the permitted parameters function.
  5. Add a private method 'find_toy' that will lookup a toy by id so we can edit it, as well as adding a rescue method for an invalid lookup should that arise, so that we can keep conventions DRY
  6. Rescue method will render a json error: item not found response
  7. Response also needs to be rendered as JSON

- Donate a toy to Goodwill (and delete it from our database)

  - How I debugged:
  1. Hit 'Donate to Goodwill' button
  2. Check Network tab, 404 response (not found)
  3. Check exception in response => No route matches [DELETE] /toys/10
  4. Check if controller route is defined in config/routes.rb
  5. Add 'destroy' to resources 
  6. Fix params[:id] to find_toy method for DRY conventions
