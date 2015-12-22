require 'rack_helper'

RSpec.describe GenericImporter do
  include_context 'shared elastic models',
                  Country,
                  Industry,
                  Topic

  include_examples 'article importer', GenericExtractor
end
