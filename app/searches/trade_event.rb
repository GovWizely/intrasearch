require 'finder'
require 'trade_event_list'
require 'trade_event_repository'
require 'trade_event_search'

module TradeEvent
  def self.all(options = {})
    TradeEventList.new(options).run
  end

  def self.search(options)
    TradeEventSearch.new(options).run
  end

  def self.find_by_id(id)
    Finder.find(TradeEventRepository.new, id).first
  end
end
