require 'yaml'

module Nix
  module Configurator
    extend self

    def configure(config, config_filename)
      yaml = YAML.load(Nix.root.join("config/#{config_filename}").read)[Nix.env]
      yaml ||= {}
      yaml.each do |key, value|
        config.send :"#{key}=", value
      end
    end
  end
end

