require 'base_article_transformer'

module StateReportTransformer
  extend BaseArticleTransformer
  extend self

  protected

  def transform_countries_and_regions(attributes, _countries)
    super attributes, ['United States']
  end
end
