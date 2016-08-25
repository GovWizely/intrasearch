require 'active_support/core_ext/string/inflections'

require 'base_article_transformer'
require 'common_importer'
require 'importer_descendants_tracker'

module BaseArticleImporter
  extend ImporterDescendantsTracker

  def self.extended(base)
    self.track_descendant base
    base.extend CommonImporter
    base.transformer = BaseArticleTransformer
  end
end
