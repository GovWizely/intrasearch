require 'active_support/core_ext/string/filters'

class TaxonomySearchQuery
  def initialize(labels, filter_by_leaf_node = nil)
    @labels = labels.map { |l| l.downcase.squish.gsub('-', ' ') }
    @filter_by_leaf_node = filter_by_leaf_node
  end

  def to_hash
    {
      query: {
        filtered: {
          filter: {
            and: build_filters
          }
        }
      }
    }
  end

  def build_filters
    filters = [{ terms: { label: @labels } }]
    filters << { term: { leaf_node: @filter_by_leaf_node } } unless @filter_by_leaf_node.nil?
    filters
  end
end
