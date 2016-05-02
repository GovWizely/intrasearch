require 'importer'
require 'taxonomy_extractor'

module TaxonomyImporter
  def self.extended(base)
    class << base
      attr_accessor :taxonomy_root_label
    end

    base.extend Importer
    base.extend ModuleMethods
  end

  module ModuleMethods
    def import(resource = Intrasearch.root.join('owl/root.owl'))
      super() do
        TaxonomyExtractor.extract(resource: resource,
                                  root_label: taxonomy_root_label).each do |hash|
          model_class.create hash
        end
      end
    end
  end
end
