require 'finder'
require 'trade_lead_repository'
require 'trade_lead_search'
require 'trade_lead_search_response'

module TradeLead
  def self.search(options)
    searcher = TradeLeadSearch.new options
    results = searcher.run
    TradeLeadSearchResponse.new searcher, results
  end

  def self.find_by_id(id)
    repository = TradeLeadRepository.new
    Finder.find(repository, id).first
  end
end
