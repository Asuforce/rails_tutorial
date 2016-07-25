# README

This is Asuforce's rails_tutorial.
If you want to set up, you can see this README.

## Ruby version

2.3.1

## System dependencies

### Development env

sqlite3: 1.3.9

### Test, Production env

MySQL: 5.7.12

## Configuration

1. Please set env values(.env.example)
2. `cp -p .env.example .env`
3. `bundle install`

## Database creation

`bundle exec rake db:create`
`bundle exec rake db:migrate`

## Database initialization

`bundle exec rake db:seed`

## How to run the test suite

`bundle exec rake test`

