source 'https://rubygems.org'

gem 'rails', '3.2.5'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mysql2'
gem 'authlogic'
gem 'will_paginate'
gem 'ransack'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'compass-rails'
end

gem 'jquery-rails'

gem "rspec-rails", :group => [:test, :development]
group :development do
  gem 'guard', '= 1.0.3' # the latest 1.1.0 version has an bug see https://github.com/guard/guard/issues/283
  gem 'guard-cucumber'
  gem "nifty-generators"
end
group :test do
  gem "factory_girl_rails"
  gem "capybara"
  gem "guard-rspec"
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
  gem 'mocha'
end
# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
