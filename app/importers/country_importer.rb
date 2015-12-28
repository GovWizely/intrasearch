require 'base_importer'
require 'country'
require 'country_extractor'
require 'taxonomy_importer'

class CountryImporter < BaseImporter
  self.model_class = Country

  def initialize(resource = Nix.root.join('skos/regions.owl.xml'))
    @resource = resource
  end

  def import
    super do
      CountryExtractor.documents(@resource).each do |country_hash|
        CountryTransformer.transform country_hash
        model_class.create country_hash
      end
    end
  end
end
