require 'yaml'

module Intrasearch
  module Configurator
    extend self

    def configure(config, config_filename)
      yaml = YAML.load(Intrasearch.root.join("config/#{config_filename}").read)[Intrasearch.env]
      yaml ||= {}
      yaml.each do |key, value|
        config.send :"#{key}=", value
      end
    end
  end
end

