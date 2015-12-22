require 'restforce'
require 'yaml'

Restforce.configure do |config|
  yaml = YAML.load(File.read(File.expand_path('../../restforce.yml', __FILE__)))[Nix.env]
  yaml ||= {}
  yaml.each do |key, value|
    config.send :"#{key}=", value
  end
  config.logger = Nix.logger
end
