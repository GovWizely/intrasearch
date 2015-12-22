require 'article_transformer'
require 'base_importer'
require 'subclassable'

class ArticleImporter < BaseImporter
  extend Subclassable
  class_attribute :extractor_module,
                  :transformer_class,
                  instance_writer: false
  self.transformer_class = ArticleTransformer

  def import
    super do
      transformer = transformer_class.new
      response = extractor_module.extract
      response.each do |attributes|
        transformer.transform attributes
        model_class.new(attributes).save
      end
    end
  end
end
