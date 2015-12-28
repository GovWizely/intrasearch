require 'taxonomy_search_query'

module TaxonomySearch
  def search_by_labels(*labels)
    if labels.present?
      query = TaxonomySearchQuery.new labels
      self.search query.to_hash
    else
      []
    end
  end
end
