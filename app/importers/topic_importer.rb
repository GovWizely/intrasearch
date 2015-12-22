require 'taxonomy_importer'
require 'topic'

class TopicImporter < TaxonomyImporter
  self.model_class = Topic

  def initialize(resource = Nix.root.join('skos/root.owl.xml'))
    super resource: resource,
          taxonomy_root_label: 'Topics',
          id_prefix: 'topic'
  end
end
