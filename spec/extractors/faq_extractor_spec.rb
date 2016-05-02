require 'rack_helper'

RSpec.describe FaqExtractor do
  include_examples 'base article extractor', 'FAQ__kav'
end
