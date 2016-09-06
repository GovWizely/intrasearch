require 'filter_by_countries_industries_query'

class TradeEventSearchQuery
  include FilterByCountriesIndustriesQuery

  append_full_text_search_fields %w(name original_description venues.name).freeze

  self.aggregation_options[:event_types] = 'event_type'
  self.aggregation_options[:states] = 'venues.state'

  self.highlight_options = {
    snippet_field: :original_description,
    title_field: :name
  }

  def initialize(countries: [], event_types: [], industries: [], limit:, offset:, q: nil, start_date_range: {}, states: [])
    @event_types = event_types.map(&:squish)
    @start_date_range = start_date_range
    @states = states.map(&:squish)

    super countries: countries,
          industries: industries,
          limit: limit,
          offset: offset,
          q: q
  end

  def to_hash
    hash = super
    hash[:sort] = sort_clause if @non_geo_name_query.blank?
    hash
  end

  protected

  def sort_clause
    [
      {
        start_date: {
          missing: '_first',
          order: 'asc'
        },
        source: {
          order: 'asc'
        }
      },
    ]
  end

  def build_filter_options
    {
      countries: @countries,
      event_type: @event_types,
      expanded_industries: @industries,
      'venues.state': @states
    }
  end

  def filter_clauses
    clauses = super
    clauses << build_start_date_range_filter if @start_date_range.present?
    clauses
  end

  def build_start_date_range_filter
    range = {}
    range[:gte] = @start_date_range[:from] if @start_date_range[:from]
    range[:lte] = @start_date_range[:to] if @start_date_range[:to]
    {
      range: {
        start_date: range
      }
    }
  end
end
