require 'find_by_id_query'
require 'trade_event_repository'

module TradeEventFinder
  def self.find(id)
    repository = TradeEventRepository.new
    query = FindByIdQuery.new id
    repository.search query
  end
end
