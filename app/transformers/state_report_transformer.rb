require 'base_article_transformer'

module StateReportTransformer
  extend BaseArticleTransformer
  extend self

  protected

  def transform_countries(attributes)
    attributes[:geographies] = ['United States']
    super
  end
end
