require 'base_importer'
require 'subclassable'
require 'taxonomy_extractor'

class TaxonomyImporter < BaseImporter
  extend Subclassable
  class_attribute :taxonomy_root_label,
                  instance_writer: false

  def initialize(resource = Nix.root.join('skos/root.owl.xml'))
    @resource = resource
  end

  def import
    super do
      TaxonomyExtractor.documents(resource: @resource,
                                  root_label: taxonomy_root_label).each do |hash|
        model_class.create hash
      end
    end
  end
end
