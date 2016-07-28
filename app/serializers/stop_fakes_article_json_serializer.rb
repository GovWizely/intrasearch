require 'article_json_serializer'

module StopFakesArticleJSONSerializer
  extend ArticleJSONSerializer

  self.url_prefix = Intrasearch.config['stop_fakes_article_url_prefix'].freeze
end
