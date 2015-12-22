require 'rubygems'
require 'bundler'
require 'rake'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  task default: [:spec]
rescue LoadError
end

task :environment do
  ENV['RACK_ENV'] ||= 'development'
  require File.expand_path('../config/environment', __FILE__)
end

Dir[File.expand_path('../lib/tasks/*.rake', __FILE__)].each do |f|
  Rake.load_rakefile f
end
