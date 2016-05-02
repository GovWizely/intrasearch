require 'airbrake'

Airbrake.configure do |config|
  Intrasearch::Configurator.configure config, 'airbrake.yml'
  config.logger = Intrasearch.logger
end

module Intrasearch
  @middlewares = [
    [Rack::ContentLength],
    [Rack::Chunked],
    [Rack::CommonLogger, @logger],
    [Rack::TempfileReaper],
    [Airbrake::Rack::Middleware]
  ]
end
