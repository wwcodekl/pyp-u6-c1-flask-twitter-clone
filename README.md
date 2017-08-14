# [pyp-w4] Twitter clone

Today's project consists on building a Twitter clone using Flask.

## About Flask

Flask is a very used Python micro Web Framework. It provides basic functionality to build web applications, like routing, request/response handling, etc. It's a "small" framework compared to other ones (like Django), but in many cases that's a great advantage.

If you are not familiar with Flask, we encourge you to take a look at these resources:
- Step by step Flask sample project: [https://github.com/rmotr/flask-introduction](https://github.com/rmotr/flask-introduction)
- FREE Flask course in Learn: [http://learn.rmotr.com/python/flask-tutorial-step-by-step](http://learn.rmotr.com/python/flask-tutorial-step-by-step)
- Or the same FREE course hosted in Udemy: [https://www.udemy.com/python-flask-tutorial-step-by-step](https://www.udemy.com/python-flask-tutorial-step-by-step)

## Setting up the database

Our data model contains just two tables (`user` and `tweet`), which are going to be stored using `SQLite`. You can use the file `twitter-schema.sql` to create your local database schema, using the following command:

```bash
$ sqlite3 twitter.db < twitter-schema.sql
```

## Testing data

Once your database is set up, you will probably need some pre loaded data before you can start testing your app. Feel free to use SQL queries to fill both tables with information. In the `twitter-schema.sql` file you will see some sample queries commented out.

Note: The `password` field in `user` table is stored as the MD5 hash of the user's password. **Remember to never store any password as plain text**

## Running the app server

Flask framework provides, out of the box, a way to run a development web server in your local machine. Just execute the `run_app.py` script available in the project and the application will stay listening at `localhost:8080`. (Make sure to have all the requirements previously installed)

```bash
$ python run_app.py
```

## Running tests

Tests are split among several files. You can run them all together doing `make test` or select individual ones with `py.test` syntax. Make sure you include the `PYTHONPATH` variable:

```bash
# All Tests
$ make test

# All Tests with py.test
$ PYTHONPATH=. py.test tests/

# Only test_profile.py
$ PYTHONPATH=. py.test tests/test_profile.py

# Only tests matching the name test_profile_authenticated_post from test_profile.py
$ PYTHONPATH=. py.test tests/test_profile.py -k test_profile_authenticated_post
```

## The application

We will have three main sections in our application: `authentication` (log in and log out), `feed` and `profile`. The feed section will be where all the user's tweets are going to be displayed. Profile section will contain user's personal data, and will allow us to update the profile information.

### Logging in

When we first visit the application, we must be redirected to the `/login` page so we can authenticate.

![login](http://i.imgur.com/amnheCL.png)

If the authentication fails, an error alert must be display saying that provided user or password were not correct. Otherwise, we must be redirected to the logged in user's feed.

### Logged user feed

![logged_feed](http://i.imgur.com/rxdkXTb.png)

When visiting the feed of the logged in user we will see, in addition to the whole list of tweets, an HTML form containing a `textarea` element. That form will allow us to post new tweets in our feed.

You will also notice that each tweet element has a cross button on the top right corner. That button must also be wrapped inside an HTML form, and will allow us to delete one particular tweet by POSTing to `/tweets/<tweet-id>/delete`.

The list of tweets must be sorted by creation date in a descending order.

### Other user feed

When the feed we are visiting does not belong to the logged in user, we won't see the tweet form on top of the page. Delete buttons must also be excluded in each tweet element. This view will be similar to the previous one, but showing data in a read only mode.

![other_feed](http://i.imgur.com/8uiPqAS.png)

### User profile

When visiting `/profile` page (log in required), the logged in user's profile information must be displayed. The page will include a HTML form containing the current personal data, which will also be used to update any field if needed.

Both successful and failed form posts must redirect back to the same profile page, displaying proper response messages.

![profile](http://i.imgur.com/6QG7hNA.png)


## Extra points

To make this application even more similar to the real Twitter service, we should expand the data model to support `following` between users.

Aside from extra tables and relationships in the database, part of the app logic should be modified. For example, in a user's feed we should display all tweets from people he is following, and not only his own tweets.

Re tweeting would also be a plus.
