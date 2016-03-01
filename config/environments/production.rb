require 'airbrake'

Airbrake.configure do |config|
  Nix::Configurator.configure config, 'airbrake.yml'
  config.logger = Nix.logger
end

module Nix
  @middlewares = [
    [Rack::ContentLength],
    [Rack::Chunked],
    [Rack::CommonLogger, @logger],
    [Rack::TempfileReaper],
    [Airbrake::Rack::Middleware]
  ]
end
