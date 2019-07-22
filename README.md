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
encoding to the unique primary key **id** Base10 (decimal) value generated 
for the new url entity. The rails application model validates that the url string 
is not repeated and not null, this prevents coalitions and duplicates urls.

The base64 encode uses all [0-9a-zA-Z] characters.
It's important to mention that when using the Base62 function 
the encoding must be case insensitive. 
Otherwise, you won’t be able to differentiate “ABC” from “ABc”.


# Routes:

| Route        | Description                                                                |
|--------------|----------------------------------------------------------------------------|
| /api-docs    |  Show Swagger documentation for all the api/v1/ endpoints                   |
| /api/sidekiq | Show the Sidekiq monitor dashboard                                         |
| /            | Show a basic table with the top ten urls stored ordered by times accessed  |
| /:short_url  | Decode short url and redirects to the original url                         |

# Deployment instructions (Heroku)


Download heroku client in your local machine
and login to heroku using the following command

```bash
heroku login
```

Deploy code to heroku
```bash
heroku create
git push heroku master
heroku run rails db:migrate
heroku run rails db:seed
heroku ps:scale fetchurlworker+1
```



