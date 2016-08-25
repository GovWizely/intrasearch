require 'finder'
require 'trade_lead_repository'
require 'trade_lead_search'

module TradeLead
  def self.search(options)
    TradeLeadSearch.new(options).run
  end

  def self.find_by_id(id)
    repository = TradeLeadRepository.new
    Finder.find(repository, id).first
  end
end
