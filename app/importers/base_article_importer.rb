require 'active_support/core_ext/string/inflections'

require 'base_article_transformer'
require 'importer'
require 'importer_descendants_tracker'

module BaseArticleImporter
  extend ImporterDescendantsTracker

  def self.extended(base)
    self.track_descendant base
    base.extend Importer

    class << base
      attr_accessor :extractor,
                    :transformer
    end

    model_name = base.name.sub(/Importer\Z/, '')
    base.extractor = "#{model_name}Extractor".constantize
    base.model_class = model_name.constantize
    base.transformer = BaseArticleTransformer

    base.extend ModuleMethods
  end

  module ModuleMethods
    def import
      super do
        response = extractor.extract
        response.each do |attributes|
          transformer.transform attributes
          model_class.create attributes
        end
      end
    end
  end
end
