# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.8.4'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails', '~> 3.5.2'

# Use postgres as the database for Active Record
gem 'pg', '~> 1.5.8'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.6.8'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails', '~> 2.0.1'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails', '~> 1.5.0'
# gem 'jsbundling-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails', '~> 1.3.4'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder', '~> 2.12.0'

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.8.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '~> 1.18.4', require: false
gem 'rexml', '~> 3.3.7'

# For Google OAuth
gem 'devise', '~> 4.9.4'
gem 'dotenv-rails', '~> 3.1.2'
gem 'omniauth', '~> 2.1.2'
gem 'omniauth-google-oauth2', '~> 1.1.3'
gem 'omniauth-rails_csrf_protection', '~> 1.0.2'

# For Shrine Photo Upload
gem 'aws-sdk-s3', '~> 1.162.0'
gem 'image_processing', '~> 1.13.0'
gem 'jquery-rails', '~> 4.6.0'
gem 'shrine', '~> 3.6.0'

# For frontend
gem 'sassc-rails', '~> 2.1.2'
gem 'simple_form', '~> 5.1.0'

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', '~> 1.9.2', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.4.3'
  gem 'rspec-rails', '~> 7.0.1'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console', '~> 4.2.1'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  gem 'capybara', '~> 3.40.0'
  gem 'selenium-webdriver', '~> 4.10.0'
  gem 'simplecov', '~> 0.22.0', require: false
  gem 'webdrivers', '~> 5.3.1'
end

gem 'brakeman', '~> 6.2.1'
gem 'rubocop', '~> 1.66.1'
gem 'simple_calendar', '~> 3.0.4'

gem 'rails-controller-testing', '~> 1.0.5'

gem 'httparty', '~> 0.22.0'
gem 'nokogiri', '~> 1.16.7'



