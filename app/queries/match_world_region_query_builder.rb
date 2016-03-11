require 'match_country_query_builder'
require 'query_builder'

module MatchWorldRegionQueryBuilder
  extend QueryBuilder

  def build(world_region)
    queries = [build_query(world_region)]
    country_queries = world_region.countries.map do |country|
      MatchCountryQueryBuilder.build country
    end
    queries.push(*country_queries)

    {
      bool: {
        should: queries
      }
    }
  end

  private

  def build_query(world_region)
    multi_match %w(atom title summary world_regions), world_region.label
  end

  extend self
end
