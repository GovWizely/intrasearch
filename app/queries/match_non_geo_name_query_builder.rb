require 'query_builder'

module MatchNonGeoNameQueryBuilder
  extend QueryBuilder

  def build(q)
    multi_match %w(atom title summary), q
  end

  extend self
end
