require 'article_transformer'

module StateReportTransformer
  extend ArticleTransformer
  extend self

  protected

  def transform_countries(attributes)
    attributes[:countries] = ['United States']
    attributes
  end
end
