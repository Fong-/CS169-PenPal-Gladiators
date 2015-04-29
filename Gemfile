source 'https://rubygems.org'

ruby '1.9.3'

gem 'rails', '3.2.16'
gem 'identicon'

group :assets do
  gem 'therubyracer'
  gem 'less-rails'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'angularjs-rails'
  gem 'angular-ui-router-rails', :git => 'https://github.com/iven/angular-ui-router-rails.git'
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
  gem 'timecop'
end

group :production do
  gem 'newrelic_rpm'
  gem 'pg'
end
