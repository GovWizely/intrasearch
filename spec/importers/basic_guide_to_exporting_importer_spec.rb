require 'rack_helper'

RSpec.describe BasicGuideToExportingImporter do
  include_context 'shared elastic models',
                  Country,
                  Industry,
                  Topic

  include_examples 'base article importer', BasicGuideToExportingExtractor
end