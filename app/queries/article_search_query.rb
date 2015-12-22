require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/filters'

class ArticleSearchQuery
  attr_reader :industry_paths,
              :limit,
              :offset,
              :q

  def initialize(countries: [], industry_paths: [], limit:, offset:, q: nil, topic_paths: [])
    @countries = countries.map { |l| l.downcase.squish }
    @industry_paths = industry_paths
    @limit = limit
    @offset = offset
    @q = q
    @topic_paths = topic_paths
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
      from: offset,
      size: limit
    }
  end

  private

  def filtered_query
    bool_queries = {}
    must_queries = []
    must_queries << multi_match_query if @q.present?
    must_queries << terms_query if @countries.present?
    bool_queries[:must] = must_queries

    should_queries = build_prefix_queries
    if should_queries
      bool_queries[:should] = should_queries
      bool_queries[:minimum_number_should_match] = 1
    end

    { filtered: { query: { bool: bool_queries } } }
  end

  def multi_match_query
    {
      multi_match: {
        fields: %w(atom title),
        operator: 'and',
        query: @q,
      }
    }
  end

  def terms_query
    {
      terms: {
        countries: @countries,
      }
    }
  end

  def aggregations
    builder = AggregationQueryBuilder.new
    builder_options = {
      countries: { field: 'countries.raw', terms: @countries },
      industries: { field: 'industry_paths', terms: @industry_paths, use_path_wildcard: true },
      types: { field: 'type' },
      topics: { field: 'topic_paths', terms: @topic_paths, use_path_wildcard: true }
    }
    builder_options.each_with_object({}) do |params, hash|
      hash.merge! builder.build(params.first, **params.last)
    end
  end

  def build_prefix_queries
    prefix_queries = build_prefix_query(@industry_paths, :industry_paths)
    prefix_queries.push *build_prefix_query(@topic_paths, :topic_paths)
    prefix_queries
  end

  def build_prefix_query(prefixes, type)
    prefixes.map do |prefix|
      {
        prefix: {
          type => prefix
        }
      }
    end
  end
end
