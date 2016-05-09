require 'support/base_article_extractor_shared_examples'

RSpec.describe FaqExtractor do
  include_examples 'base article extractor', 'FAQ__kav'
end
