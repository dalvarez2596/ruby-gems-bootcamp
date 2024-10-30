source "https://rubygems.org"

ruby "3.2.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.2.1"
# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"
# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# bootstrap
gem "bootstrap", "~> 5.3", ">= 5.3.3"

gem "dartsass-sprockets", "~> 3.1"

# Iconos de font awesome
gem "font-awesome-sass", "~> 6.5", ">= 6.5.2"

# haml files
gem "haml-rails", "~> 2.1"

# Para poder usar el conversor de html.erb to ham
gem "html2haml", "~> 2.3"

# compatible para los forms con bootstrap, hay que hacer una config
gem "simple_form", "~> 5.3", ">= 5.3.1"

# Fake data
gem "faker", "~> 3.4", ">= 3.4.2"

# authentication devise
gem "devise", "~> 4.9", ">= 4.9.4"

# friendly urls
gem "friendly_id", "~> 5.5", ">= 5.5.1"

# searching filters:
gem "ransack", "~> 4.2", ">= 4.2.1"

# show users activity:

gem "public_activity", "~> 3.0", ">= 3.0.1"

# roles

gem "rolify", "~> 6.0", ">= 6.0.1"

# Autorizacion system

gem "pundit", "~> 2.4"

# Pagination

gem "pagy", "~> 9.1", ">= 9.1.1"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
end
