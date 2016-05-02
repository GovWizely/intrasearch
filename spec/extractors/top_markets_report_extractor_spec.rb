require 'rack_helper'

RSpec.describe TopMarketsReportExtractor do
  include_examples 'base article extractor', 'Top_Markets__kav'
end
