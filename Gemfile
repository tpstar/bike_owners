source 'http://rubygems.org'

gem 'sinatra'
gem 'activerecord', :require => 'active_record'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
gem 'rack-flash3'
gem 'rake'
gem 'require_all'
gem 'thin'
gem 'bcrypt'
gem 'puma'


group :development do
  gem 'sqlite3'
  gem "tux"
  gem 'shotgun'
  gem 'pry'
end

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'rack-test'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'
end

group :production do
  gem 'pg'
  gem 'activerecord-postgresql-adapter'
end
