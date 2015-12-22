require 'restforce'

require 'article_extractor'
require 'extractable'

module CountryCommercialGuideExtractor
  extend Extractable
  self.api_name = 'Country_Commercial__kav'.freeze
  extend ArticleExtractor
end
