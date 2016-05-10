require 'importer'
require 'web_document'
require 'web_document_extractor'
require 'web_document_transformer'

module WebDocumentImporter
  extend Importer

  self.model_class = WebDocument

  module ModuleMethods
    def import
      super do
        Intrasearch.config['web_document_domains'].each do |domain|
          import_domain domain
        end
      end
    end

    private

    def import_domain(domain)
      WebDocumentExtractor.extract(domain).each do |web_document_hash|
        WebDocumentTransformer.transform domain, web_document_hash
        WebDocument.create web_document_hash
      end
    end
  end

  extend ModuleMethods
end
