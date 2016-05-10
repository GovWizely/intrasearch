require 'search'
require 'web_document_search'

class WebDocumentSearchAPI < Grape::API
  version 'v1'

  params do
    requires :domains, type: String, allow_blank: false
    optional :q, type: String

    optional :limit,
             type: Integer,
             values: 1..Search::MAX_LIMIT
    optional :offset,
             type: Integer,
             values: Search::DEFAULT_OFFSET..Search::MAX_OFFSET
  end

  get '/web_documents/search' do
    WebDocumentSearch.new(declared(params)).run
  end
end
