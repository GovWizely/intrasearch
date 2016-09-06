require 'filter_by_countries_industries_query'

class TradeLeadSearchQuery
  include FilterByCountriesIndustriesQuery

  append_full_text_search_fields %w(description title).freeze

  self.highlight_options = {
    snippet_field: :description,
    title_field: :title
  }
end
