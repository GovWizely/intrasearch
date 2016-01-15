require 'article_transformer'
require 'importer'

module ArticleImporter
  class << self
    attr_accessor :descendants
  end

  self.descendants = []

  def self.extended(base)
    self.descendants |= [base]

    class << base
      attr_accessor :extractor,
                    :transformer
    end
    base.transformer = ArticleTransformer

    base.extend Importer
    base.extend ModuleMethods
  end

  module ModuleMethods
    def import
      super do
        response = extractor.extract
        response.each do |attributes|
          transformer.transform attributes
          model_class.new(attributes).save
        end
      end
    end
  end
end
