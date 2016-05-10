require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/filters'

require 'country'
require 'query_builder'
require 'query_parser'
require 'web_page_highlight_builder'
require 'world_region'

class BaseArticleSearchQuery
  include QueryBuilder
  include WebPageHighlightBuilder

  def initialize(countries: [], industries: [], limit:, offset:, q: nil, topics: [], trade_regions: [], world_regions: [])
    @countries = countries.map(&:squish)
    @industries = industries.map(&:squish)
    @limit = limit
    @offset = offset
    @topics = topics.map(&:squish)
    @trade_regions = trade_regions.map(&:squish)
    @world_regions = world_regions.map(&:squish)

    @q = q

    query_parser_results = QueryParser.parse(@q)
    @non_geo_name_query = query_parser_results[:non_geo_name_query]
    @taxonomies = query_parser_results[:taxonomies]
  end

  def to_hash
    {
      query: {
        bool: {
          must: must_clauses,
          filter: filter_clauses
        }
      },
      aggs: aggregations,
      highlight: highlight(@q, :atom),
      from: @offset,
      size: @limit
    }
  end

  private

  def must_clauses
    must_clauses = []
    must_clauses << multi_match(%w(atom title summary), @non_geo_name_query) if @non_geo_name_query.present?
    must_clauses.push(*build_taxonomy_queries)
  end

  def build_taxonomy_queries
    @taxonomies.map do |taxonomy|
      case taxonomy
      when Country
        multi_match %w(atom countries^3 title summary), taxonomy.label
      when WorldRegion
        multi_match %w(atom title summary world_regions^3), taxonomy.label
      end
    end
  end

  def filter_clauses
    filters = {
      countries: @countries,
      industries: @industries,
      topics: @topics,
      trade_regions: @trade_regions,
      world_regions: @world_regions
    }

    filters.map do |field, values|
      { terms: { field => values } } if values.present?
    end.compact
  end

  def aggregations
    aggregation_options = {
      countries: 'countries',
      industries: 'industry_paths',
      topics: 'topic_paths',
      trade_regions: 'trade_regions',
      types: 'type',
      world_regions: 'world_region_paths'
    }
    aggregation_options.each_with_object({}) do |params, hash|
      hash.merge! AggregationQueryBuilder.build(params.first, params.last)
    end
  end
end
