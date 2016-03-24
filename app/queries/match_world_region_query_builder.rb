require 'match_country_query_builder'
require 'query_builder'

module MatchWorldRegionQueryBuilder
  extend QueryBuilder

  def build(world_region)
    multi_match %w(atom title summary world_regions^3),
                world_region.label
  end

  extend self
end
