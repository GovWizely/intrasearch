require 'article_importer'
require 'generic'
require 'generic_extractor'

class GenericImporter < ArticleImporter
  self.extractor_module = GenericExtractor
  self.model_class = ::Generic
end
