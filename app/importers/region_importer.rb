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
    def import(resource = Nix.root.join('skos/regions.owl.xml'))
      super() do
        extractor.documents(resource).each do |trade_region_hash|
          model_class.create trade_region_hash
        end
      end
    end

  end
end
