ENV['RACK_ENV'] ||= 'test'

require 'simplecov'

SimpleCov.minimum_coverage 100
SimpleCov.start do
  add_filter '/config/initializers/server.rb'
  add_filter '/spec/'
  track_files '{app,lib}/**/*.rb'
end

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require File.expand_path('../../config/environment', __FILE__)

require 'rack/test'
require 'rspec'
require 'spec_helper'
require 'elastic_helper'
require 'base_article_helper'
require 'api_spec_helper'
