require 'base_article_search'
require 'country_commercial_guide'
require 'market_insight'
require 'market_intelligence'
require 'state_report'
require 'top_markets_report'

class MarketIntelligenceSearch
  include BaseArticleSearch

  TYPES = [
    CountryCommercialGuide,
    MarketInsight,
    MarketIntelligence,
    StateReport,
    TopMarketsReport
  ].freeze

  def initialize(options)
    options[:types] = TYPES
    super
  end
end
