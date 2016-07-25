require 'base_article_search'
require 'country_commercial_guide'
require 'market_insight'
require 'state_report'
require 'top_markets_report'

class MarketIntelligenceSearch
  include BaseArticleSearch

  TYPES = [
    CountryCommercialGuide,
    MarketInsight,
    StateReport,
    TopMarketsReport
  ].freeze

  def initialize(options)
    options[:types] = TYPES
    super
  end
end
