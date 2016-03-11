require 'article_transformer'

module StateReportTransformer
  extend ArticleTransformer
  extend self

  protected

  def transform_countries(attributes)
    attributes[:geographies] = ['United States']
    super
  end
end
