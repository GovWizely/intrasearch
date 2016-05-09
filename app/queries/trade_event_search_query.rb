require 'geo_name_search_query'

class TradeEventSearchQuery
  include GeoNameSearchQuery

  self.full_text_search_fields = %w(description name venues).freeze

  self.aggregation_options = {
    countries: 'countries',
    industries: 'industry_paths',
    sources: 'source',
    trade_regions: 'trade_regions',
    world_regions: 'world_region_paths'
  }

  self.highlight_options = {
    snippet_field: :description,
    title_field: :name
  }

  def initialize(countries: [], industries: [], limit:, offset:, q: nil, trade_regions: [], world_regions: [])
    super countries:countries,
          limit: limit,
          offset: offset,
          q: q,
          trade_regions: trade_regions,
          world_regions: world_regions

    @industries = industries.map(&:squish)
    @filter_options = {
      countries: @countries,
      industries: @industries,
      trade_regions: @trade_regions,
      world_regions: @world_regions
    }
  end
end
