require 'rack_helper'

RSpec.describe MarketInsightImporter do
  include_context 'shared elastic models',
                  Country,
                  Industry,
                  Topic

  include_examples 'base article importer', MarketInsightExtractor
end
