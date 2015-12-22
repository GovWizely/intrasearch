require 'active_support/logger'
require 'active_support/string_inquirer'
require 'pathname'

module Nix
  @env = ActiveSupport::StringInquirer.new ENV['RACK_ENV']

  @root = Pathname.new File.expand_path('../../', __FILE__)

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

  @default_middlewares = begin
    m = Hash.new {|h,k| h[k] = []}
    non_production_middlewares = [
      [Rack::ContentLength],
      [Rack::Chunked],
      [Rack::CommonLogger, @logger],
      [Rack::ShowExceptions],
      [Rack::Lint],
      [Rack::TempfileReaper]
    ]

    m['development'] = non_production_middlewares
    m['test'] = non_production_middlewares
    m['production'] = [
        [Rack::ContentLength],
        [Rack::Chunked],
        [Rack::CommonLogger, @logger],
        [Rack::TempfileReaper]
      ]
    m
  end

  @middlewares = begin
    @default_middlewares[@env]
  end

  class << self
    attr_reader :env, :logger, :middlewares, :root
  end
end
