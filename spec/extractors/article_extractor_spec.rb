require 'rack_helper'

RSpec.describe ArticleExtractor do
  include_examples 'base article extractor', 'Article__kav'
end
