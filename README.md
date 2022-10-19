# README

# This is a Rails JSON API - Book repository

Project propertyes:

* Ruby version - 3.1.2

* Rails version - 7.0.4

Configration of project:

* Database on deployment - Postgresql

* Database on development and testing - Sqlite3

* Authentificate was maked with JWT tokens

* Authorization with email confirmation

## Deployed on heroku
https://books-repository-tabake.herokuapp.com/ - base url

https://books-repository-tabake.herokuapp.com/api/v1/ - api url

# Quick guide

## Get books (jwt auth disabled)
* GET api/v1/books

Get request 'api/v1/books' without parameters returns 100 exists books.
Parameters must be:
limit, offset.

For get second page with limit 10 we need use:

* GET api/v1/books?limit=10&offset=10

For default limit is 100 books.
For getting books don`t need be a user.

## Registration
* POST api/v1/registration

This request must have a body with created user, for example:

{
    "user": {
        "email": "some mail",
        "username": "some username",
        "password": "some password"
    }
}

Response body of this request is created user id from database.

Also, this request send a mail to created user with confirmation link.
To send mail confirmation again, should send a new request:

* POST api/v1/registration/confirm

Body for this request:
{"id":"some integer id"}

## Authentification
* POST api/v1/authenticate

Body example:

{
    "username": "some username",
    "password": "some password"
}

Response has a jwt token for create and delete books (full permissions, except users data in database).

## Post book
* POST api/v1/books

Request need a jwt token in a header and json body. Example of body:

{
    "book": {
        "title": "Some book",
        "description": "Some book description",
        "path": "someurl"
    },
    "author": {
        "first_name": "FName",
        "last_name": "LName",
        "age": "25"
    }
}

Book must have an author. If author exist in database, book just creates a reference from self to this author.

Path of book may be a magnet url, cloud url or other pathes.

## Delete book
* DEL api/v1/books/{{id}}

Request need a jwt token in a header.
