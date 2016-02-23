require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/filters'

class ArticleSearchQuery
  def initialize(countries: [], industries: [], limit:, offset:, q: nil, topics: [], trade_regions: [], world_regions: [])
    @countries = normalize_array_of_str countries
    @industries = normalize_array_of_str industries
    @limit = limit
    @offset = offset
    @q = q
    @topics = normalize_array_of_str topics
    @trade_regions = normalize_array_of_str trade_regions
    @world_regions = normalize_array_of_str world_regions
  end

  def to_hash
    {
      query: filtered_query,
      aggs: aggregations,
      highlight: {
        fields: {
          atom: { fragment_size: 255, number_of_fragments: 1 },
          summary: { fragment_size: 255, number_of_fragments: 1 },
          title: { number_of_fragments: 0 }
        }
      },
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
    must_queries << multi_match_query if @q.present?

    terms = {
      countries: @countries,
      industries: @industries,
      topics: @topics,
      trade_regions: @trade_regions,
      world_regions: @world_regions
    }
    must_queries.push(*build_term_queries(terms))

    { filtered: { query: { bool: { must: must_queries } } } }
  end

  def multi_match_query
    {
      multi_match: {
        fields: %w(atom title summary),
        operator: 'and',
        query: @q,
      }
    }
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
    builder = AggregationQueryBuilder.new
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
                       terms: @trade_regions },
      types: { field: 'type' },
      world_regions: { field: 'world_region_paths',
                       terms: @world_regions,
                       use_path_wildcard: true },
    }
    builder_options.each_with_object({}) do |params, hash|
      hash.merge! builder.build(params.first, **params.last)
    end
  end
end
