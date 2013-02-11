source 'http://rubygems.org'

gem 'rails', '3.0.20'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mysql', '2.8.1'
gem 'i18n'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
gem 'ruby-debug19', :require => 'ruby-debug'

gem 'web-app-theme', '>= 0.6.2'

group :development, :test do
  gem "rspec-rails", :group => [:test, :development]
  gem "cucumber-rails", :require => false
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner'
  gem "capybara"
  gem "launchy"
end

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end

