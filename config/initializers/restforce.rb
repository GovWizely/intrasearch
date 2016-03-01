require 'restforce'

Restforce.configure do |config|
  Nix::Configurator.configure config, 'restforce.yml'
  config.logger = Nix.logger
end
