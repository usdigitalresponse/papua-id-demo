# Introduction

This is a Rails application which demonstrates a system for allowing claimants to initiate and manage unemployment claims, and for customer service representatives to process claims.

# Prerequisites

* [rvm](https://rvm.io/)
* Ruby 2.7.1 (`rvm install "ruby-2.7.1"`)
* Node and NPM (`sudo apt update && sudo apt install nodejs npm`)
* Webpack (`npm install --save-dev webpack && npm install --save-dev webpack-cli`)
* Postgres (`sudo apt update && sudo apt install postgresql postgresql-contrib` on Ubuntu)
* Postgres user `papua/papua` (`sudo -u postgres psql -c "CREATE USER papua WITH PASSWORD 'papua';"`)
* Grant "superuser" to papua user (`sudo -u postgres psql -c "ALTER USER papua WITH SUPERUSER;"`)

# Setup

* Clone this repo (e.g. `git clone git@github.com:usdigitalresponse/papua-id-demo.git`)
* Change to the repo directory: `cd papua-id-demo`
* Install Ruby dependencies: `bundle install`
* Install Yarn dependencies: `yarn install --check-files`
* Create a `config/database.yml` file (`cp config/database.yml.example config/database.yml`)
* Edit `config/database.yml` to add info to `default` section:
	* `username: papua`
	* `password: papua`
	* `host: localhost`
* Create the database: `rake db:create`
* Run database migrations: `rails db:migrate RAILS_ENV=development`
* Set up Rails credentials for Alloy:
	* `rails credentials:edit --environment development`
	* Add placeholder like:
        
        alloy:<br>
        &nbsp;&nbsp;&nbsp;&nbsp;uri: https://stuff.com
* Start the rails server `rails server`
* Visit [http://localhost:3000/](http://localhost:3000/) to see the server running!

# Testing

* Set up Rails credentials for Alloy:
	* `rails credentials:edit --environment test`
	* Add placeholder like:
        
        alloy:<br>
        &nbsp;&nbsp;&nbsp;&nbsp;uri: https://stuff.com
* Run rspec tests (`rspec`)