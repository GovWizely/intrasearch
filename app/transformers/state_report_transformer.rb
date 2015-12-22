class StateReportTransformer < ArticleTransformer

  protected

  def transform_countries(attributes)
    attributes[:countries] = ['United States']
    attributes
  end
end
