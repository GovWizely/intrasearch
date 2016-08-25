require 'find_by_id_query'

module Finder
  def self.find(repository, id)
    query = FindByIdQuery.new id
    repository.search query
  end
end
