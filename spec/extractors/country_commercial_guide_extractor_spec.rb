require 'rack_helper'

RSpec.describe CountryCommercialGuideExtractor do
  include_examples 'base article extractor', 'Country_Commercial__kav'
end
