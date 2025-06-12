source "https://rubygems.org"

gem "rails", "~> 8.0.2"
gem "propshaft" # Keep if you still serve some static assets
gem "sqlite3", ">= 2.1"
gem "puma", ">= 5.0"
# Remove: gem "jsbundling-rails"
# Remove: gem "turbo-rails"
# Remove: gem "stimulus-rails"
# Remove: gem "cssbundling-rails"
gem "jbuilder"
gem "rack-cors", require: "rack/cors"

gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"
gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end