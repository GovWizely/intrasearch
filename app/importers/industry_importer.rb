require 'industry'
require 'taxonomy_importer'

class IndustryImporter < TaxonomyImporter
  self.model_class = Industry
  self.taxonomy_root_label = 'Industries'.freeze
end
