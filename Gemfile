source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
gem "rails", "~> 5.1.6"
gem "puma", "~> 3.7"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"
gem "devise"
gem "bootstrap-sass"
gem "jquery-rails"
gem "font-awesome-rails"
gem "activerecord-import", "~> 0.15.0"
gem "axlsx", "= 2.0.1"
gem "axlsx_rails"
gem "selenium-webdriver"

group :development, :test do
  gem "pry"
  gem "capybara", "~> 2.13"
  gem "rspec-rails", "~> 3.7"
  gem "factory_bot_rails"
  gem "better_errors"
  gem "mysql2"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :production do
  gem "rails_12factor"
  gem "pg"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
