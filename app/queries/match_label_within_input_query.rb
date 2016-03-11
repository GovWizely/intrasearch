class MatchLabelWithinInputQuery
  def initialize(input)
    @input = input
  end

  def to_hash
    {
      query: {
        filtered: {
          query: {
            match: {
              label: {
                analyzer: 'query_analyzer',
                query: @input
              }
            }
          }
        }
      },
      sort: [{ label: 'asc' }]
    }
  end
end
