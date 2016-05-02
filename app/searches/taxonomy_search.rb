require 'match_label_within_input_query'
require 'repository'

module TaxonomySearch
  def search_for_labels_within_input(types, input)
    repository = Repository.new types
    repository.search MatchLabelWithinInputQuery.new(input)
  end

  extend self
end
