module AggregationQueryBuilder
  def self.build(aggregation_options)
    aggregation_options.each_with_object({}) do |(name, field), hash|
      hash[name] = {
        terms: {
          field: field,
          order: { _term: 'asc' },
          size: 0
        }
      }
    end
  end
end
