require 'active_support/logger'
require 'active_support/string_inquirer'
require 'pathname'
require 'yaml'

module Intrasearch
  @env = ActiveSupport::StringInquirer.new ENV['RACK_ENV']

  @root = Pathname.new File.expand_path('../../', __FILE__)

  @config = YAML.load(@root.join('config/intrasearch.yml').read)[@env]

  @logger = begin
    logger_file = ::File.new(@root.join("log/#{@env}.log"), 'a+')
    logger_file.sync = true
    logger_instance = ::ActiveSupport::Logger.new logger_file

    unless @env.production?
      console_logger = ::ActiveSupport::Logger.new STDERR
      logger_instance.extend ::ActiveSupport::Logger.broadcast console_logger
    end
    logger_instance.level = ::Logger::INFO unless @env.development?
    logger_instance
  end

  class << self
    attr_reader :config, :env, :logger, :middlewares, :root
  end
end

require_relative 'configurator'
require_relative "environments/#{Intrasearch.env}"
