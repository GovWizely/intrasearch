require 'base_article_extractor'
require 'extractable'

module CountryCommercialGuideExtractor
  extend Extractable
  self.api_name = 'Country_Commercial__kav'.freeze
  extend BaseArticleExtractor
end
