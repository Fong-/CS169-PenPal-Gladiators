source 'https://rubygems.org'

ruby '1.9.3'

gem 'rails', '3.2.16'

group :assets do
  gem 'therubyracer'
  gem 'less-rails'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'angularjs-rails'
  gem 'angular-ui-bootstrap-rails'
  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  gem 'sqlite3'
  gem 'rake'
  gem 'debugger'
  gem 'simplecov', :require => false
  gem 'database_cleaner'
  gem 'jasmine-rails'
  gem 'rspec-rails', '2.14'
  gem 'cucumber-rails', :require => false
  gem 'capybara'
  gem 'poltergeist'
  gem 'capybara-angular'
  gem 'codeclimate-test-reporter'

group :production do
  gem 'pg'
end
