require 'query_builder'

module MatchCountryQueryBuilder
  extend QueryBuilder

  def build(country_label)
    multi_match %w(atom countries title summary), country_label
  end

  extend self
end
