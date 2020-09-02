# Introduction

This is a Rails application which demonstrates a system for allowing claimants to initiate and manage unemployment claims, and for customer service representatives to process claims.

# Prerequisites

* [rvm](https://rvm.io/)
* Ruby 2.7.1: `rvm install "ruby-2.7.1"`
* The Foreman gem: `gem install foreman`
* Node and NPM: `sudo apt update && sudo apt install nodejs npm`
* Webpack: `npm install --save-dev webpack && npm install --save-dev webpack-cli`
* Postgres: `sudo apt update && sudo apt install postgresql postgresql-contrib` on Ubuntu
* Create a Postgres user for the app to run as.  One example for how to do this:
	* `sudo -u postgres psql -c "CREATE USER papua WITH PASSWORD 'papua';"`
	* `sudo -u postgres psql -c "ALTER USER papua WITH SUPERUSER;"`
* Redis: `sudo apt update && sudo apt install redis-server` on Ubuntu

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
* Run database migrations: `rails db:migrate`
* Set up Rails credentials:
	* Request a copy of the `master.key` file from another team member
	* Store `master.key` in the `config` directory- it should be in the same folder as `credentials.yml.enc`
* Start the rails server using Foreman: `foreman start`
* Visit [http://localhost:5000/](http://localhost:5000/) to see the server running!

# Testing

There are no automated tests at this time, as this is "just a demo."  You can, of course, start the service and test it manually.