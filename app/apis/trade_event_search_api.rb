require 'filter_by_countries_industries_search_api'
require 'trade_event'

class TradeEventSearchAPI < Grape::API
  extend FilterByCountriesIndustriesSearchAPI

  params do
    optional :event_types, type: String
    optional :result_type, type:String, default: 'snippet', values: %w(snippet fields)
    optional :start_date_range, type: Hash do
      optional :from, type: Date, coerce_with: -> (d) { Date.strptime(d, '%Y-%m-%d') unless d.blank? }
      optional :to, type: Date, coerce_with: -> (d) { Date.strptime(d, '%Y-%m-%d') unless d.blank? }
      at_least_one_of :from, :to
    end
    optional :states, type: String

    at_least_one_of :countries,
                    :event_types,
                    :industries,
                    :q,
                    :states,
                    :start_date_range
  end

  get '/trade_events/search' do
    TradeEvent.search declared(params, include_missing: false)
  end
end
