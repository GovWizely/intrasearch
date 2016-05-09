require 'aggregation_query_builder'
require 'query_builder'
require 'web_page_highlight_builder'

class WebDocumentSearchQuery
  include QueryBuilder

  FULL_TEXT_FIELDS = %w(content description title).freeze

  def initialize(domains:, include_aggregations:, limit:, offset:, q: nil)
    @domains = domains
    @include_aggregations = include_aggregations
    @limit = limit
    @offset = offset
    @q = q
  end

  def to_hash
    query = {
      query: {
        bool: {
          must: must_clauses,
          filter: filter_clauses
        }
      },
      highlight: highlight_clause,
      from: @offset,
      size: @limit
    }
    query[:aggs] = aggregations if @include_aggregations
    query[:sort] = [{ url: 'asc' }] if @q.blank?

    query
  end

  def must_clauses
    @q.present? ? [multi_match(FULL_TEXT_FIELDS, @q)] : []
  end

  def filter_clauses
    @domains.present? ? [{ terms: { domain: @domains } }] : []
  end

  def highlight_clause
    WebPageHighlightBuilder.build @q, snippet_field: :content
  end

  def aggregations
    AggregationQueryBuilder.build domains: :domain
  end
end
