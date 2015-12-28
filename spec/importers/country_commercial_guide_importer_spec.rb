require 'rack_helper'


RSpec.describe CountryCommercialGuideImporter do
  include_context 'shared elastic models',
                  Country,
                  Industry,
                  Topic,
                  TradeRegion

  include_examples 'article importer', CountryCommercialGuideExtractor
end
