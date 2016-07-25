require 'shared_params'

module BaseArticleSearchAPI
  def self.extended(base)
    base.helpers SharedParams
    base.params do
      use :base_article, :pagination
    end
  end
end
