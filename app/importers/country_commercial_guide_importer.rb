require 'article_importer'
require 'country_commercial_guide'
require 'country_commercial_guide_extractor'

class CountryCommercialGuideImporter < ArticleImporter
  self.extractor_module = CountryCommercialGuideExtractor
  self.model_class = CountryCommercialGuide
end
