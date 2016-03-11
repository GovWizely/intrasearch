require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/filters'

require 'country'
require 'highlight_field_builder'
require 'match_country_query_builder'
require 'match_non_geo_name_query_builder'
require 'match_world_region_query_builder'
require 'query_parser'
require 'world_region'

class ArticleSearchQuery
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
      terms_query(field => values) if values.present?
    end.compact
  end

  def terms_query(terms)
    {
      terms: terms
    }
  end

  def aggregations
    builder_options = {
      countries: { field: 'countries.raw',
                   terms: @countries },
      industries: { field: 'industry_paths',
                    terms: @industries,
                    use_path_wildcard: true },
      topics: { field: 'topic_paths',
                terms: @topics,
                use_path_wildcard: true },
      trade_regions: { field: 'trade_regions.raw',
                       terms: @trade_region_filters },
      types: { field: 'type' },
      world_regions: { field: 'world_region_paths',
                       terms: @world_region_filters,
                       use_path_wildcard: true },
    }
    builder_options.each_with_object({}) do |params, hash|
      hash.merge! AggregationQueryBuilder.build(params.first, **params.last)
    end
  end

  def highlight
    return {} if @original_query.blank?

    {
      fields: {
        atom: HighlightFieldBuilder.build(:atom, @original_query),
        summary: HighlightFieldBuilder.build(:summary, @original_query),
        title: HighlightFieldBuilder.build(:title, @original_query, 0)
      }
    }
  end
end
