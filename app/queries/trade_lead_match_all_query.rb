require 'match_all_query'

class TradeLeadMatchAllQuery
  include MatchAllQuery

  def to_hash
    hash = super
    hash[:sort] = [
      {
        published_at: {
          missing: '_first',
          order: 'asc'
        }
      },
      { source: 'asc' }
    ]
    hash
  end
end