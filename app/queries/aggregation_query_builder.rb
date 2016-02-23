class AggregationQueryBuilder
  def build(name, field: nil, terms: nil, use_path_wildcard: false)
    field ||= name
    build_aggregations(name, field, terms, use_path_wildcard)
  end

  private

  def build_aggregations(name, field, terms, use_path_wildcard)
    terms_agg = {
      field: field,
      order: { _term: 'asc' },
      size: 0
    }

    if terms.present?
      terms_agg[:include] = {
        pattern: aggregation_pattern(terms, use_path_wildcard),
        flags: 'CASE_INSENSITIVE'
      }
    end

    {
      name => {
        terms: terms_agg
      }
    }
  end

  def aggregation_pattern(terms, use_path_wildcard = false)
    terms_str = terms.join('|')
    use_path_wildcard ? ".*/(#{terms_str})(/.+)?" : terms_str
  end
end
