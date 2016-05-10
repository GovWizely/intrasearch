require 'repository'
require 'search'
require 'web_document'
require 'web_document_search_query'
require 'web_document_search_response'

class WebDocumentSearch
  include Search

  def initialize(options)
    super
    @domains = options[:domains].to_s.split(',').map(&:squish)
  end

  def run
    repository = Repository.new WebDocument
    results = repository.search build_query
    WebDocumentSearchResponse.new self, results
  end

  private

  def build_query
    WebDocumentSearchQuery.new domains: @domains,
                               include_aggregations: search_type_count?,
                               limit: @limit,
                               offset: @offset,
                               q: @q
  end
end
