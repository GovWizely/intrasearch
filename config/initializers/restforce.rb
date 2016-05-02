require 'restforce'

Restforce.configure do |config|
  Intrasearch::Configurator.configure config, 'restforce.yml'
  config.logger = Intrasearch.logger
end
