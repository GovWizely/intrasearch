module Intrasearch
  @middlewares = [
    [Rack::ContentLength],
    [Rack::Chunked],
    [Rack::CommonLogger, @logger],
    [Rack::ShowExceptions],
    [Rack::Lint],
    [Rack::TempfileReaper]
  ]
end
