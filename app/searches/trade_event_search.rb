require 'filter_by_countries_industries_search'
require 'trade_event_repository'
require 'trade_event_search_query'

class TradeEventSearch
  include FilterByCountriesIndustriesSearch

  self.repository_class = TradeEventRepository
  self.query_class = TradeEventSearchQuery

  def initialize(options)
    super
    @start_date_range = options[:start_date_range]
    @states = options[:states].to_s.split(',')
    @event_types = options[:event_types].to_s.split(',')
  end

  protected

  def query_params
    query_params_hash = super
    query_params_hash[:event_types] = @event_types
    query_params_hash[:start_date_range] = @start_date_range
    query_params_hash[:states] = @states
    query_params_hash
  end
end
