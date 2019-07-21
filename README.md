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

## Database creation
Using Rails create all the databases migrations


```bash
rails db:setup
rails db:migrate
```


## Database initialization

Use seed.rb file for inserting initial values into the database

```bash
rails db:seed
```

## Services (job queues, cache servers, search engines, etc.)

### Job Scheduling

Resque Scheduler job 

Using rails console queue sleeper
```ruby
Resque.enqueue(Sleeper)
```

```bash
rake resque:scheduler
```

Create a new Work using sidekiq 
command
```ruby
rails g sidekiq:worker 
```

Start sidekick from the root of the rails application
so the jobs will be processed

```bash
bundle exec sidekiq -d -L log/sidekiq.log -e <evironment>
```


### Swagger documentation 

```bash 
rails generate rspec:install
rails g rswag:install

```

Generate swagger api docs json file from spects 
using the following code

```bash
rake rswag:specs:swaggerize
```

# URL short code Algorithm

In this project the Short Code algorithm applies a base64
encoding in the unique primary key **id** Base10 (decimal) value generated 
for the new url entity. The application rails model validates that the url string 
is not repeated and not null, this prevents coalitions and duplicates urls.

The base64 encode uses characters that goes from [0-9a-zA-Z].
It's important to mention that when using the Base62 function 
the encoding must be case insensitive. 
Otherwise, you won’t be able to differentiate “ABC” from “ABc”.


# Deployment instructions (Heroku probably)


Create respective databases for production database

```bash
rails db:create db:migrate RAILS_ENV=production
```
Set production database credentials
in the config/database.yml 



