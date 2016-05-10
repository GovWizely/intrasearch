module QueryBuilder
  def multi_match(fields, query)
    {
      multi_match: {
        fields: fields,
        operator: 'and',
        query: query,
        type: 'cross_fields'
      }
    }
  end
end
