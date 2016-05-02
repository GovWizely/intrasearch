require 'rack_helper'

RSpec.describe ArticleImporter do
  include_context 'shared elastic models',
                  Country,
                  Industry,
                  Topic

  include_examples 'base article importer', ArticleExtractor
end
