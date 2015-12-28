require 'taxonomy_importer'
require 'topic'

class TopicImporter < TaxonomyImporter
  self.model_class = Topic
  self.taxonomy_root_label = 'Topics'.freeze
end
