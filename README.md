# Viva API [![Build Status](https://travis-ci.org/andela-tpeters/viva.svg?branch=develop)](https://travis-ci.org/andela-tpeters/viva) [![Coverage Status](https://coveralls.io/repos/github/andela-tpeters/viva/badge.svg?branch=develop)](https://coveralls.io/github/andela-tpeters/viva?branch=develop) [![Code Climate](https://codeclimate.com/github/andela-tpeters/viva/badges/gpa.svg)](https://codeclimate.com/github/andela-tpeters/viva)

## Overview

Viva is an API that lets you manage a bucket list. A bucket list is simply a number of experiences or achievements that a person hopes to have or accomplish during their lifetime.



## Getting Started

Visit the [Viva API Documentation](http://vivaapi.herokuapp.com/). It is clearly written and easy to understand and use.



## External Dependencies

All the dependencies can be found in the [Gemfile](https://github.com/andela-tpeters/viva/blob/develop/Gemfile)



## Available End Points
Below is the list of available endpoints in the Viva API. Some end points are not available publicly and hence, can only be accessed when you sign up and log in.

<table>
<tr>
  <th>End Point</th>
  <th>Functionality</th>
  <th>Public Access</th>
</tr>

<tr>
  <td>GET /api/v1/bucketlists</td>
  <td>List all the created bucket lists</td>
  <td>FALSE</td>
</tr>

<tr>
  <td>POST /api/v1/bucketlists</td>
  <td>Create a new bucket list</td>
  <td>FALSE</td>
</tr>

<tr>
  <td>GET /bucketlists/:id</td>
  <td>Get single bucket list</td>
  <td>FALSE</td>
</tr>

<tr>
  <td>PUT /bucketlists/:id</td>
  <td>Update this bucket list</td>
  <td>FALSE</td>
</tr>

<tr>
  <td>DELETE /bucketlists/:id</td>
  <td>Delete this single bucket list</td>
  <td>FALSE</td>
</tr>

<tr>
  <td>GET /bucketlists/:id/items</td>
  <td>Lists all items in the single bucket list.</td>
  <td>FALSE</td>
</tr>

<tr>
  <td>POST /bucketlists/:id/items</td>
  <td>Creates a new item in the bucket list</td>
  <td>FALSE</td>
</tr>

<tr>
  <td>PUT /bucketlists/:id/items/:item_id</td>
  <td>Updates a bucket list item</td>
  <td>FALSE</td>
</tr>

<tr>
  <td>DELETE /bucketlists/:id/items/:item_id</td>
  <td>Deletes an item in a bucket list</td>
  <td>FALSE</td>
</tr>
</table>



<h3>JSON Data Model</h3>
A typical bucket list requested by a user would look like this:
```bash
  {
    id: 1,
    name: “Goal”,
    items: [
           {
               id: 1,
               name: “I to do this before the end of this year”,
               done: false,
               date_created: "2016-01-01 00:00:00",
               date_created: "2016-01-01 00:00:00"
             }
           ],
    date_created: "2016-01-01 00:00:00",
    date_created: "2016-01-01 00:00:00",
    created_by: “John”
}
```


<h3> Pagination </h3>
The Viva API comes with pagination by default, so the number of results to display to users can be specified when listing the bucket lists, by supplying the <code>page</code> and <code>limit</code> in the request to the API.

<h4>Example</h4>
<b>Request:</b>
<pre>
GET https://vivaapiapi.herokuapp.com/api/v1/bucketlists?page=2&limit=20
</pre>

<b>Response:</b>
<pre>
20 bucket list records belonging to the logged in user starting from the 21st gets returned.
</pre>



<b>Searching by Name</b>
Users can search for a bucket list by using it's name as the search parameter when making a <code>GET</code> request to list the bucketlists.

<h4>Example</h4>

<b>Request:</b>
```bash
  GET https://vivaapi.herokuapp.com/api/v1/bucketlists?q="bucket1"
```

<b>Response:</b>
```bash
Bucket lists that include name “bucket1” gets returned
```



<h3> Versions</h3>
viva API currently has only one version and can be accessed via this link - <a href="https://vivaapi.herokuapp.com/api/v1/">https://vivaapi.herokuapp.com/api/v1/</a>



<h3>Running Test</h3>
The Bucket List API uses `rspec` for testing. Continuous Integration is carried out via Travis CI.

To test locally, go through the following steps.

1. Clone the repo to your local machine.

  ```bash
  $  git clone git@github.com:andela-tpeters/viva.git
  ```

2. `cd` into the `viva` folder.

  ```bash
  $  cd viva
  ```

3. Install dependencies

  ```bash
    $  bundle install
  ```

4. Set up and migrate the database.

  ```bash
  $ rake db:setup && rake db:migrate
  ```

5. Run the tests.

  ```bash
  $  bundle exec rspec
  ```


<h3>Limitations</h3>
The API might not be able to handle large requests but this will be reviewed as users increase.
