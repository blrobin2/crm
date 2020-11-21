source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'devise'
gem 'enumerations'
gem 'honeybadger', '~> 4.0'
gem 'jsonapi_parameters'
gem 'jsonapi-serializer'
gem 'json_api_responders'
gem 'jwt'
gem 'kaminari'
gem 'memoist'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'pundit'
gem 'rack-cors'
gem 'rails', '~> 6.0.3', '>= 6.0.3.4'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'dox', require: false
  gem 'factory_bot_rails'
  gem 'rspec-rails'
end

group :development do
  gem 'annotate'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'brakeman', require: false
  gem 'bullet'
  gem 'bundler-audit', require: false
  gem 'listen', '~> 3.2'
  gem 'overcommit', require: false
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end

group :test do
  gem 'fivemat'
  gem 'json-schema'
  gem 'json_matchers'
  gem 'shoulda-matchers'
  gem 'timecop'
  gem 'vcr'
  gem 'webmock'
end
