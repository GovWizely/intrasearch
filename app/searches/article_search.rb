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
              :industry_paths,
              :limit,
              :next_offset,
              :offset,
              :q,
              :topic_paths,
              :total,
              :trade_regions,
              :types

  def initialize(options)
    @countries = options[:countries].to_s.split(',')
    @industry_paths = lookup_industry_paths options[:industries]
    @limit = options[:limit] || Search::DEFAULT_LIMIT
    @offset = options[:offset] || Search::DEFAULT_OFFSET
    @q = options[:q]
    @search_type = options[:search_type] || {}
    @topic_paths = lookup_topic_paths options[:topics]
    @trade_regions = options[:trade_regions].to_s.split(',')
    @types = detect_types options[:types]
  end

  def run
    repository = ArticleRepository.new types: @types
    results = repository.search build_query, search_type: @search_type
    ArticleSearchResponse.new self, results
  end

  def build_query
    ArticleSearchQuery.new(countries: @countries,
                           industry_paths: @industry_paths,
                           limit: @limit,
                           offset: @offset,
                           q: @q,
                           topic_paths: @topic_paths,
                           trade_regions: @trade_regions)
  end

  def search_type_count?
    :count == @search_type
  end

  private

  def lookup_industry_paths(industries_str)
    Industry.search_by_labels(*industries_str.to_s.split(',')).map(&:path)
  end

  def lookup_topic_paths(topics_str)
    Topic.search_by_labels(*topics_str.to_s.split(',')).map(&:path)
  end

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
