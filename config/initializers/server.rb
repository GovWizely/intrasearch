require 'rack'
require 'rack/server'
module Rack

  class Server
    class << self
      def default_middleware_by_environment
        Hash.new {|h,k| h[k] = []}
      end
    end
  end
end
