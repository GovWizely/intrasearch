require 'country'
require 'taxonomy_importer'

class CountryImporter < TaxonomyImporter
  self.model_class = Country

  def initialize(resource = Nix.root.join('skos/root.owl.xml'))
    super max_depth: 1,
          resource: resource,
          taxonomy_root_label: 'Countries',
          id_prefix: 'country'
  end
end
