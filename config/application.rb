$LOAD_PATH.unshift(*Dir.glob(File.join(File.dirname(__FILE__), '..', 'app', '**/')))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require_relative 'boot'

require 'grape'
require 'rack/cors'

require_relative 'base'
require_relative 'eager_loader'

Intrasearch::EagerLoader.load(Intrasearch.root.join('config/initializers'), false)
Intrasearch::EagerLoader.load(Intrasearch.root.join('app/**'), true)

module Intrasearch
  class Application < Grape::API
    use ::Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: :get
      end
    end

    format :json
    content_type :json, 'application/json; charset=utf-8'
    mount HowToExportArticleCountAPI
    mount HowToExportArticleSearchAPI
    mount MarketIntelligenceCountAPI
    mount MarketIntelligenceSearchAPI
  end
end
