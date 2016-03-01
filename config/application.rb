$LOAD_PATH.unshift(*Dir.glob(File.join(File.dirname(__FILE__), '..', 'app', '**/')))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require_relative 'boot'

require 'grape'
require 'rack/cors'

require_relative 'base'
require_relative 'eager_loader'

Nix::EagerLoader.load(Nix.root.join('config/initializers'), false)
Nix::EagerLoader.load(Nix.root.join('app/**'), true)

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
