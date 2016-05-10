module BaseArticleAttributes
  def self.included(base)
    base.class_eval do
      attribute :atom, String, mapping: { analyzer: 'english_analyzer' }
      attribute :countries, String, mapping: { index: 'not_analyzed' }

      attribute :industries, String, mapping: { index: 'not_analyzed' }
      attribute :industry_paths, String, mapping: { analyzer: 'path_analyzer' }
      attribute :summary, String, mapping: { analyzer: 'english_analyzer' }
      attribute :topic_paths, String, mapping: { analyzer: 'path_analyzer' }
      attribute :topics, String, mapping: { index: 'not_analyzed' }
      attribute :title, String, mapping: { analyzer: 'english_analyzer' }
      attribute :trade_regions, String, mapping: { index: 'not_analyzed' }

      attribute :type,
                String,
                default: name.demodulize.titleize,
                mapping: { index: 'not_analyzed' }
      attribute :url, String, mapping: { index: 'not_analyzed' }
      attribute :world_region_paths, String, mapping: { analyzer: 'path_analyzer' }
      attribute :world_regions, String, mapping: { index: 'not_analyzed' }
    end
  end
end
