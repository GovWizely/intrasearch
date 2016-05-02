require 'rack_helper'

RSpec.describe TopMarketsReportImporter do
  include_context 'shared elastic models',
                  Country,
                  Industry,
                  Topic

  include_examples 'base article importer', TopMarketsReportExtractor
end
