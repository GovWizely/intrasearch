require 'industry'
require 'taxonomy_importer'

class IndustryImporter < TaxonomyImporter
  self.model_class = Industry

  def initialize(id_prefix: 'industry', resource: Nix.root.join('skos/root.owl.xml'), taxonomy_root_label: 'Industries')
    super id_prefix: id_prefix,
          resource: resource,
          taxonomy_root_label: taxonomy_root_label
  end
end
