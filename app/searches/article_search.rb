require 'article_repository'
require 'article_search_query'
require 'article_search_response'
require 'country_commercial_guide'
require 'generic'
require 'market_insight'
require 'search'
require 'state_report'
require 'top_markets_report'

class ArticleSearch
  ALL_TYPES = [CountryCommercialGuide,
               Generic,
               MarketInsight,
               StateReport,
               TopMarketsReport].freeze

  attr_reader :count,
              :countries,
              :industries,
              :limit,
              :next_offset,
              :offset,
              :q,
              :topics,
              :total,
              :trade_regions,
              :types,
              :world_regions

  def initialize(options)
    @countries = options[:countries].to_s.split(',')
    @industries = options[:industries].to_s.split(',')
    @limit = options[:limit] || Search::DEFAULT_LIMIT
    @offset = options[:offset] || Search::DEFAULT_OFFSET
    @q = options[:q]
    @search_type = options[:search_type] || {}
    @topics = options[:topics].to_s.split(',')
    @trade_regions = options[:trade_regions].to_s.split(',')
    @types = detect_types options[:types]
    @world_regions = options[:world_regions].to_s.split(',')
  end

  def run
    repository = ArticleRepository.new types: @types
    results = repository.search build_query, search_type: @search_type
    ArticleSearchResponse.new self, results
  end

  def build_query
    ArticleSearchQuery.new(countries: @countries,
                           industries: @industries,
                           limit: @limit,
                           offset: @offset,
                           q: @q,
                           topics: @topics,
                           trade_regions: @trade_regions,
                           world_regions: @world_regions)
  end

  def search_type_count?
    :count == @search_type
  end

  private

  def detect_types(types_str)
    @types = []
    normalized_type_str = types_str.to_s.gsub(/\s+/, '').downcase
    @types << CountryCommercialGuide if normalized_type_str =~ /\bcountrycommercialguide\b/
    @types << Generic if normalized_type_str =~ /\bgeneric\b/
    @types << MarketInsight if normalized_type_str =~ /\bmarketinsight\b/
    @types << StateReport if normalized_type_str =~ /\bstatereport\b/
    @types << TopMarketsReport if normalized_type_str =~ /\btopmarketsreport\b/
    @types = ALL_TYPES if @types.empty?
    @types
  end
end
