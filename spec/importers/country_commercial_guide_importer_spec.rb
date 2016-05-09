require 'support/base_article_importer_shared_examples'
require 'support/elastic_model_shared_contexts'

RSpec.describe CountryCommercialGuideImporter do
  include_context 'elastic models',
                  Country,
                  Industry,
                  Topic

  include_examples 'base article importer', CountryCommercialGuideExtractor
end
