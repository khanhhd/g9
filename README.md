# README

This README would normally document whatever steps are necessary to get the
application up and running.

## Things you may want to cover:

* Ruby version

  2.3.1

* Database creation

  ```
  rake db:create
  rake db:migrate
  ```

* Database initialization

  ```
  rake db:seed
  ```

* How to run the test suite

  ```
    rspec spec/
  ```

* API document

  http://localhost:3000/apipie


## Logic note

* User only will be in an status sleep or awake
* When User go to bed, a tracking_sleep record will be created and start_time will be updad). when he wakeup, last tracking_sleep (sleeping status) will be updated end_time and `period` (start_time - end_time)
* Relationship table is used for storing followed and follower user
