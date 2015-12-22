require 'taxonomy_search_query'

class IndustrySearch
  def initialize(labels, filter_by_leaf_node = nil)
    @labels = labels
    @filter_by_leaf_node = filter_by_leaf_node
  end

  def run
    if @labels.present?
      query = TaxonomySearchQuery.new(@labels,
                                      @filter_by_leaf_node)
      Industry.search query.to_hash
    else
      []
    end
  end
end
