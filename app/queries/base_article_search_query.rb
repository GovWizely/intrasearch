require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/filters'

require 'country'
require 'match_country_query_builder'
require 'match_non_geo_name_query_builder'
require 'match_world_region_query_builder'
require 'query_parser'
require 'world_region'

class BaseArticleSearchQuery
  def initialize(countries: [], industries: [], limit:, offset:, q: nil, topics: [], trade_regions: [], world_regions: [])
    @countries = normalize_array_of_str countries
    @industries = normalize_array_of_str industries
    @limit = limit
    @offset = offset
    @topics = normalize_array_of_str topics
    @trade_region_filters = normalize_array_of_str trade_regions
    @world_region_filters = normalize_array_of_str world_regions

    @original_query = q

    query_parser_results = QueryParser.parse(@original_query)
    @q = query_parser_results[:non_geo_name_query]
    @taxonomies = query_parser_results[:taxonomies]
  end

  def to_hash
    {
      query: filtered_query,
      aggs: aggregations,
      highlight: highlight,
      from: @offset,
      size: @limit
    }
  end

  private

  def normalize_array_of_str(array)
    array.map { |l| l.downcase.squish }
  end

  def filtered_query
    must_queries = []
    must_queries << MatchNonGeoNameQueryBuilder.build(@q) if @q.present?

    must_queries.push(*build_taxonomy_queries)

    terms = {
      countries: @countries,
      industries: @industries,
      topics: @topics,
      trade_regions: @trade_region_filters,
      world_regions: @world_region_filters
    }
    must_queries.push(*build_term_queries(terms))

    { filtered: { query: { bool: { must: must_queries } } } }
  end

  def build_taxonomy_queries
    @taxonomies.map do |taxonomy|
      case taxonomy
      when Country
        MatchCountryQueryBuilder.build taxonomy.label
      when WorldRegion
        MatchWorldRegionQueryBuilder.build taxonomy
      end
    end
  end

  def build_term_queries(terms)
    terms.map do |field, values|
      { terms: { field => values } } if values.present?
    end.compact
  end

  def aggregations
    aggregation_options = {
      countries: 'countries.raw',
      industries: 'industry_paths',
      topics: 'topic_paths',
      trade_regions: 'trade_regions.raw',
      types: 'type',
      world_regions: 'world_region_paths'
    }
    aggregation_options.each_with_object({}) do |params, hash|
      hash.merge! AggregationQueryBuilder.build(params.first, params.last)
    end
  end

  def highlight
    return {} if @original_query.blank?

    {
      fields: {
        atom: { fragment_size: 255, number_of_fragments: 1 },
        summary: { fragment_size: 255, number_of_fragments: 1 },
        title: { number_of_fragments: 0 }
      }
    }
  end
end
