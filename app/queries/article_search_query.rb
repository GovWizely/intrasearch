require 'active_support/core_ext/string/filters'

require 'geo_name_search_query'

class ArticleSearchQuery
  include GeoNameSearchQuery

  append_full_text_search_fields %w(atom title summary).freeze

  self.aggregation_options = {
    countries: 'countries',
    industries: 'industry_paths',
    topics: 'topic_paths',
    trade_regions: 'trade_regions',
    world_regions: 'world_region_paths'
  }

  self.highlight_options = {
    snippet_field: :atom
  }

  def initialize(countries: [], guides: [], industries: [], limit:, offset:, q: nil, topics: [], trade_regions: [], world_regions: [])
    super countries: countries,
          limit: limit,
          offset: offset,
          q: q,
          trade_regions: trade_regions,
          world_regions: world_regions

    @industries = industries.map(&:squish)
    @topics = topics.map(&:squish)

    @filter_options = {
      countries: @countries,
      guide: guides,
      industries: @industries,
      topics: @topics,
      trade_regions: @trade_regions,
      world_regions: @world_regions
    }
  end
end
