class TradeEventMatchAllQuery
  def initialize(limit:, offset:)
    @limit = limit
    @offset = offset
  end

  def to_hash
    {
      query: {
        match_all: {}
      },
      sort: [
        {
          start_date: {
            missing: '_first',
            order: 'asc'
          }
        },
      ],
      from: @offset,
      size: @limit
    }
  end
end
