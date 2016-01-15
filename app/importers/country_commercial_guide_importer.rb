require 'article_importer'
require 'country_commercial_guide'
require 'country_commercial_guide_extractor'

module CountryCommercialGuideImporter
  extend ArticleImporter

  self.extractor = CountryCommercialGuideExtractor
  self.model_class = CountryCommercialGuide
end
