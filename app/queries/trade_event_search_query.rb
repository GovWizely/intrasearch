require 'filter_by_countries_industries_query'

class TradeEventSearchQuery
  include FilterByCountriesIndustriesQuery

  append_full_text_search_fields %w(description name venues).freeze

  self.highlight_options = {
    snippet_field: :description,
    title_field: :name
  }
end
