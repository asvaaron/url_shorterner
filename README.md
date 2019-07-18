# README

This README documents the most important aspects
of the url_shorterner app.

# Ruby and Rails versions

For this project we are using 

| Ruby      | Rails      | 
|:--------: |:---------: |
|2.6.3p62   |  6.0.0.rc1 |

# Development Environment

Install bundler 

```bash
gem install bundler

```

Then install all the gem dependencies provides in the
**Gemfile** using the following commands

```bash
bundle install
```

# Database creation
Using Rails create all the databases migrations


```bash
rails db:setup
rails db:migrate
```


# Database initialization

Use seed.rb file for inserting initial values into the database

```bash
rails db:seed

```

# Services (job queues, cache servers, search engines, etc.)

Resque Scheduler job 

Using rails console queue sleeper
```ruby
Resque.enqueue(Sleeper)
```

```bash
rake resque:scheduler
```
# Deployment instructions (Heroku probably)


Create respective databases for production database

```bash
rails db:create db:migrate RAILS_ENV=production
```
Set production database credentials
in the config/database.yml 



