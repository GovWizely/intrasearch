require 'rack_helper'

RSpec.describe MarketInsightExtractor do
  include_examples 'base article extractor', 'Market_Insight__kav'
end
