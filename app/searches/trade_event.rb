require 'finder'
require 'model_ids_collector'
require 'trade_event_fields_search_response'
require 'trade_event_list'
require 'trade_event_repository'
require 'trade_event_search'
require 'trade_event_search_response'

module TradeEvent
  def self.ids
    ModelIdsCollector.collect(*TradeEventRepository::MODELS)
  end

  def self.all(options = {})
    TradeEventList.new(options).run
  end

  def self.search(options)
    searcher = TradeEventSearch.new options
    results = searcher.run
    response_class = options[:result_type] == 'fields' ? TradeEventFieldsSearchResponse : TradeEventSearchResponse
    response_class.new searcher, results
  end

  def self.find_by_id(id)
    Finder.find(TradeEventRepository.new, id).first
  end
end
