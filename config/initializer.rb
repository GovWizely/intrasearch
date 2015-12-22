module Nix
  class Initializer
    attr_reader :paths

    def initialize(*paths)
      @paths = paths
    end

    def run
      paths.each do |path|
        Dir[path].each do |f|
          require f
        end
      end
    end
  end
end
