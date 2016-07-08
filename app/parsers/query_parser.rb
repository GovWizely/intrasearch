require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/filters'

require 'country'
require 'taxonomy_search'
require 'trade_region'
require 'world_region'

module QueryParser
  GEO_MODEL_TYPES = [Country, TradeRegion, WorldRegion].freeze

  def parse(q)
    return build_parsed_hash(q) if q.blank?

    normalized_query = normalize q
    taxonomies = TaxonomySearch.search_for_labels_within_input GEO_MODEL_TYPES,
                                                               normalized_query
    extract normalized_query, taxonomies
  end

  private

  def normalize(q)
    q.tr('-,', ' ').gsub(/\s*\band\b\s*/, ' ').squish
  end

  def extract(normalized_query, taxonomies)
    return build_parsed_hash(normalized_query) if taxonomies.blank?

    taxonomies.sort! { |a, b| b.label.length <=> a.label.length }
    detected_taxonomies = taxonomies.select do |taxonomy|
      analyzed_label = taxonomy.hit['sort'].first
      normalized_query.gsub!(/#{Regexp.escape(analyzed_label)}/i, '')
    end

    build_parsed_hash normalized_query.squish,
                      taxonomies: detected_taxonomies
  end

  def build_parsed_hash(q, taxonomies: [])
    {
      non_geo_name_query: q,
      taxonomies: taxonomies
    }
  end

  extend self
end
