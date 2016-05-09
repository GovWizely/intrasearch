require 'webservices'

Webservices.configure do |config|
  Intrasearch::Configurator.configure config, 'webservices.yml'
end
