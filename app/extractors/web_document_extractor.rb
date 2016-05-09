require 'json'
require 'restforce'
require 'sanitize'
require 'uri'

module WebDocumentExtractor
  SERVICE_TEMPLATE = '/services/apexrest/content?site=%{domain}&since=0'.freeze

  module ModuleMethods
    def extract(domain)
      collection = get_collection domain
      Enumerator.new(collection.size) do |y|
        collection.each do |document|
          y << extract_document(document)
        end
      end
    end

    private

    def get_collection(domain)
      client = Restforce.new
      service_path = SERVICE_TEMPLATE % { domain: domain }
      response = client.get service_path
      JSON.parse response.body
    end

    def extract_document(document)
      fields = %i(content description title url).map do |field_symbol|
        [field_symbol, sanitize_value(document[field_symbol.to_s])]
      end
      Hash[fields]
    end

    def sanitize_value(value)
      Sanitize.fragment(value).squish if value
    end
  end

  extend ModuleMethods
end
