require 'yaml'

module USState
  ALL = YAML.load Intrasearch.root.join('config/us_states.yml').read
end
