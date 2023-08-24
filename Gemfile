source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'active_type', '>= 2.3.2'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'closure_tree'
gem 'devise', '>= 4.9.0'
gem 'email_validator', '>= 2.2.4'
gem 'enumerations'
gem 'figaro'
gem 'honeybadger', '~> 4.0'
gem 'jsonapi_parameters'
gem 'json_api_responders'
gem 'jsonapi-serializer'
gem 'jwt'
gem 'kaminari'
gem 'memoist'
gem 'paper_trail', '>= 14.0.0'
gem 'pg', '>= 0.18', '< 2.0'
gem 'phonelib'
gem 'puma', '~> 4.1'
gem 'pundit', '>= 2.3.0'
gem 'rack-cors'
gem 'rails', '~> 6.1.7', '>= 6.1.7.5'
gem 'scenic', '>= 1.7.0'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'dox', '>= 2.2.0', require: false
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails', '>= 6.0.0'
end

group :development do
  gem 'annotate'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'brakeman', require: false
  gem 'bullet', '>= 7.0.4'
  gem 'bundler-audit', require: false
  gem 'listen', '~> 3.2'
  gem 'overcommit', require: false
  gem 'rubocop', require: false
  gem 'rubocop-rails', '>= 2.17.0', require: false
  gem 'rubocop-rspec', require: false
end

group :test do
  gem 'fivemat'
  gem 'json_matchers'
  gem 'json-schema'
  gem 'shoulda-matchers', '>= 5.3.0'
  gem 'simplecov', '< 0.18', require: false
  gem 'timecop'
  gem 'vcr'
  gem 'webmock'
end
