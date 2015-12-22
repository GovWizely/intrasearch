require 'base_importer'
require 'owl_parser'
require 'subclassable'


class TaxonomyImporter < BaseImporter
  extend Subclassable

  def initialize(resource:, taxonomy_root_label:, id_prefix:, max_depth: nil)
    @max_depth = max_depth
    @resource = resource
    @id_prefix = id_prefix
    @taxonomy_root_label = taxonomy_root_label
  end

  def import
    super do
      File.open(@resource) do |f|
        OwlParser.new(file: f,
                      id_prefix: @id_prefix,
                      max_depth: @max_depth,
                      root_label: @taxonomy_root_label).each_class do |class_hash|
          model_class.create class_hash
        end
      end
    end
  end
end
