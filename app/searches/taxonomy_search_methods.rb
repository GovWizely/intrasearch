require 'match_label_query'

module TaxonomySearchMethods
  def search_by_labels(*labels)
    if labels.present?
      query = MatchLabelQuery.new labels
      search query.to_hash
    else
      []
    end
  end
end
