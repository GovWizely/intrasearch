require 'base_article_search'

class MarketIntelligenceSearch < BaseArticleSearch
  TYPES = [
    CountryCommercialGuide,
    MarketInsight,
    StateReport,
    TopMarketsReport].freeze

  def initialize(options)
    options[:types] = TYPES
    super
  end
end
