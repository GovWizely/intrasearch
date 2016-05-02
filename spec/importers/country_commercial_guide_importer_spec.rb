require 'rack_helper'

RSpec.describe CountryCommercialGuideImporter do
  include_context 'shared elastic models',
                  Country,
                  Industry,
                  Topic

  include_examples 'base article importer', CountryCommercialGuideExtractor
end
