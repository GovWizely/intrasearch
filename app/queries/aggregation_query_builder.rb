module AggregationQueryBuilder
  def self.build(name, field)
    {
      name => {
        terms: {
          field: field,
          order: { _term: 'asc' },
          size: 0
        }
      }
    }
  end
end
