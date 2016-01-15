require 'country'
require 'country_extractor'
require 'importer'

module CountryImporter
  extend Importer

  self.model_class = Country

  def self.import(resource = Nix.root.join('skos/regions.owl.xml'))
    super() do
      CountryExtractor.documents(resource).each do |country_hash|
        CountryTransformer.transform country_hash
        model_class.create country_hash
      end
    end
  end
end
