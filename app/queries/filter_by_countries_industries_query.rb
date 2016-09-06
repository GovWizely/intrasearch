require 'geo_name_search_query'

module FilterByCountriesIndustriesQuery
  def self.included(base)
    base.include GeoNameSearchQuery
    base.include InstanceMethods

    base.aggregation_options = {
      countries: 'countries',
      industries: 'industry_paths',
      sources: 'source'
    }
  end

  module InstanceMethods
    def initialize(countries: [], industries: [], limit:, offset:, q: nil)
      super countries: countries,
            limit: limit,
            offset: offset,
            q: q

      @industries = industries.map(&:squish)
      @filter_options = build_filter_options
    end

    protected

    def build_filter_options
      {
        countries: @countries,
        expanded_industries: @industries
      }
    end
  end
end
