require 'article'
require 'base_article_search'
require 'basic_guide_to_exporting'
require 'faq'

class HowToExportArticleSearch
  include BaseArticleSearch

  TYPES = [
    Article,
    BasicGuideToExporting,
    Faq
  ].freeze

  def initialize(options)
    options[:types] = TYPES
    super
  end
end
