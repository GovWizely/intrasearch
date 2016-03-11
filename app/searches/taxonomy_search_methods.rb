require 'match_label_within_input_query'
require 'match_label_query'

module TaxonomySearchMethods
  def search_by_labels(*labels)
    if labels.present?
      query = MatchLabelQuery.new labels
      self.search query.to_hash
    else
      []
    end
  end
end
