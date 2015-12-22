$LOAD_PATH.unshift(*Dir.glob(File.join(File.dirname(__FILE__), '..', 'app', '**')))
$LOAD_PATH.unshift(*Dir.glob(File.join(File.dirname(__FILE__), '..', 'lib')))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'boot'

require 'grape'
require 'rack/cors'

require 'base'
require 'initializer'

Nix::Initializer.new(
  File.expand_path('../initializers/*.rb', __FILE__),
  File.expand_path('../../app/**/*.rb', __FILE__)).run

module Nix
  class Application < Grape::API
    use ::Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: :get
      end
    end

    format :json
    mount ArticleCountAPI
    mount ArticleSearchAPI
  end
end
