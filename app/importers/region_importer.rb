require 'importer'

module RegionImporter
  def self.extended(base)
    class << base
      attr_accessor :extractor
    end

    base.extend Importer
    base.extend ModuleMethods
  end

  module ModuleMethods
    def import(resource = Nix.root.join('owl/regions.owl'))
      super() do
        extractor.extract(resource).each do |region_hash|
          model_class.create region_hash
        end
      end
    end

  end
end