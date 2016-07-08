require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/filters'

require 'country'
require 'query_builder'
require 'query_parser'
require 'web_page_highlight_builder'
require 'world_region'

module GeoNameSearchQuery
  def self.included(base)
    base.module_eval do
      @countries_search_fields = %w(countries^3)
      @trade_regions_search_fields = %w(trade_regions^3)
      @world_regions_search_fields = %w(world_regions^3)

      class << base
        attr_accessor :aggregation_options,
                      :highlight_options
        attr_reader :countries_search_fields,
                    :full_text_search_fields,
                    :trade_regions_search_fields,
                    :world_regions_search_fields

        def append_full_text_search_fields(fields)
          @full_text_search_fields = fields
          @countries_search_fields |= fields
          @trade_regions_search_fields |= fields
          @world_regions_search_fields |= fields
        end
      end
    end

    base.include QueryBuilder
  end

  def initialize(countries: [], limit:, offset:, q: nil, trade_regions: [], world_regions: [])
    @countries = countries.map(&:squish)
    @limit = limit
    @offset = offset
    @trade_regions = trade_regions.map(&:squish)
    @world_regions = world_regions.map(&:squish)

    @q = q

    query_parser_results = QueryParser.parse @q
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
      aggs: aggregations_clause,
      highlight: highlight_clause,
      from: @offset,
      size: @limit
    }
  end

  protected

  def highlight_clause
    WebPageHighlightBuilder.build @q, self.class.highlight_options
  end

  def must_clauses
    must_clauses = []
    if @non_geo_name_query.present?
      must_clauses << multi_match(self.class.full_text_search_fields,
                                  @non_geo_name_query)
    end
    must_clauses.push(*build_taxonomy_queries)
  end

  def build_taxonomy_queries
    @taxonomies.map do |taxonomy|
      case taxonomy
      when Country
        multi_match self.class.countries_search_fields, taxonomy.label
      when TradeRegion
        multi_match self.class.trade_regions_search_fields, taxonomy.label
      when WorldRegion
        multi_match self.class.world_regions_search_fields, taxonomy.label
      end
    end
  end

  def filter_clauses
    @filter_options.map do |field, values|
      { terms: { field => values } } if values.present?
    end.compact
  end

  def aggregations_clause
    AggregationQueryBuilder.build self.class.aggregation_options
  end
end
