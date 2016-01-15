require 'taxonomy_importer'
require 'topic'

module TopicImporter
  extend TaxonomyImporter

  self.model_class = Topic
  self.taxonomy_root_label = 'Topics'.freeze
end
