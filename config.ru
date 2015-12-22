require File.expand_path('../config/environment', __FILE__)
Nix.middlewares.reverse_each do |middleware|
  klass, *args = middleware
  use klass, *args
end
run Nix::Application
