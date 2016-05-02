require 'rack_helper'

RSpec.describe FaqImporter do
  include_context 'shared elastic models',
                  Country,
                  Industry,
                  Topic

  include_examples 'base article importer', FaqExtractor
end
