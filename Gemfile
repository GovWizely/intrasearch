source 'https://rubygems.org'

gem 'activesupport', '~> 4.2.11.1'
gem 'addressable'
gem 'elasticsearch', '~> 2.0.1'
gem 'elasticsearch-model', '~> 2.0.1'
gem 'elasticsearch-persistence', '~> 2.0.1'
gem 'grape'
gem 'hashie', '~> 3.4.6'
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
  gem 'rack-test'
  gem 'rspec'
  gem 'simplecov', require: false
end

group :development, :test do
  gem 'pry'
end

group :production do
  gem 'airbrake'
  gem 'newrelic_rpm'
  gem 'unicorn'
end
