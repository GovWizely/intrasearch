require 'article_importer'
require 'generic'
require 'generic_extractor'

module GenericImporter
  extend ArticleImporter

  self.extractor = GenericExtractor
  self.model_class = ::Generic
end
