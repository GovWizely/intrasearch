$LOAD_PATH.unshift(*Dir.glob(File.join(File.dirname(__FILE__), '..', 'app', 'indices/templates')))
$LOAD_PATH.unshift(*Dir.glob(File.join(File.dirname(__FILE__), '..', 'app', '**')))
$LOAD_PATH.unshift(*Dir.glob(File.join(File.dirname(__FILE__), '..', 'lib')))

require_relative 'boot'

require 'grape'
require 'rack/cors'

require_relative 'base'
require_relative 'eager_loader'

Intrasearch.eager_load Intrasearch.root.join('lib')
Intrasearch.eager_load Intrasearch.root.join('config'),
                       'initializers/*.rb',
                       false
Intrasearch.eager_load Intrasearch.root.join('app', '*')
Intrasearch.eager_load Intrasearch.root.join('app', 'indices', 'templates')

%w(apis extractors models transformers importers).each do |dir_name|
Intrasearch.eager_load Intrasearch.root.join('app', dir_name),
                       '*/*.rb'
end

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
    mount PrivacyShieldArticleCountAPI
    mount PrivacyShieldArticleSearchAPI
    mount StopFakesArticleCountAPI
    mount StopFakesArticleSearchAPI
    mount TradeEventsAPI
    mount TradeLeadsAPI
    mount WebDocumentCountAPI
    mount WebDocumentSearchAPI
    mount Admin::TradeEventsAPI
    mount Admin::UsersAPI
  end
end
