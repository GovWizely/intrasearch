source 'https://rubygems.org'

gem 'activesupport', '~> 4.2.7'
gem 'addressable'
gem 'elasticsearch-persistence'
gem 'grape'
gem 'rake'
gem 'rack-console'
gem 'rack-cors', require: 'rack/cors'
gem 'restforce'
gem 'sanitize'
gem 'typhoeus'
gem 'yajl-ruby', require: 'yajl'

group :development do
  gem 'guard'
  gem 'guard-rack'
end

group :test do
  gem 'codeclimate-test-reporter', require: false
  gem 'rack-test'
  gem 'rspec'
  gem 'simplecov', require: false
end

group :development, :test do
  gem 'pry'
end

group :production do
  gem 'airbrake', '~> 5.1'
  gem 'newrelic_rpm'
  gem 'unicorn'
end
