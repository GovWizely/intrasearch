require 'web_document_search'

class WebDocumentCountAPI < Grape::API
  version 'v1'

  get '/web_documents/count' do
    WebDocumentSearch.new(search_type: :count).run
  end
end
