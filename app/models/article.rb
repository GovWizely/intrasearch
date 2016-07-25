require 'base_article'

class Article
  include BaseArticle
  attribute :guide, String, mapping: { analyzer: 'keyword_analyzer' }
  attribute :url_name, String, mapping: { index: 'not_analyzed' }
end
