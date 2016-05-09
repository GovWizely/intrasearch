require 'shared_params'
require 'web_document_search'

class WebDocumentSearchAPI < Grape::API
  helpers SharedParams
  version 'v1'

  params do
    use :pagination
    requires :domains, type: String, allow_blank: false
    optional :q, type: String
  end

  get '/web_documents/search' do
    WebDocumentSearch.new(declared(params)).run
  end
end
