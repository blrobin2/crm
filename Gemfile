source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'active_type'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'devise'
gem 'enumerations'
gem 'figaro'
gem 'honeybadger', '~> 4.0'
gem 'jsonapi_parameters'
gem 'json_api_responders'
gem 'jsonapi-serializer'
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
  gem 'json_matchers'
  gem 'json-schema'
  gem 'shoulda-matchers'
  gem 'simplecov', '< 0.18', require: false
  gem 'timecop'
  gem 'vcr'
  gem 'webmock'
end
