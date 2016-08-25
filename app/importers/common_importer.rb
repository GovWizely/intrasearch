require 'importer'

module CommonImporter
  def self.extended(base)
    base.extend Importer

    class << base
      attr_accessor :extractor,
                    :transformer
    end

    base.model_class = base.name.sub(/Importer$/, '').constantize
    base.extractor = "#{base.model_class.name}Extractor".constantize
    base.extend ModuleMethods
  end

  module ModuleMethods
    def import
      super do
        items = extractor.extract
        items.each do |item|
          transformer.transform item
          model_class.create item
        end
      end
    end
  end
end
