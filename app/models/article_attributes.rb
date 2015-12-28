module ArticleAttributes
  KEYWORD_ATTRIBUTE_MAPPING = {
    mapping: {
      analyzer: 'keyword_analyzer',
      fields: {
        raw: {
          index: 'not_analyzed',
          type: 'string'
        }
      }
    }
  }

  def self.included(base)
    base.class_eval do
      attribute :atom, String, mapping: { analyzer: 'english_analyzer' }
      attribute :countries,
                String,
                KEYWORD_ATTRIBUTE_MAPPING.clone

      attribute :industries, String, mapping: { index: 'not_analyzed' }
      attribute :industry_paths, String, mapping: { analyzer: 'path_analyzer' }
      attribute :summary, String, mapping: { analyzer: 'english_analyzer' }
      attribute :topic_paths, String, mapping: { analyzer: 'path_analyzer' }
      attribute :topics, String, mapping: { index: 'not_analyzed' }
      attribute :title, String, mapping: { analyzer: 'english_analyzer' }
      attribute :trade_regions,
                String,
                KEYWORD_ATTRIBUTE_MAPPING.clone

      attribute :type,
                String,
                default: self.name.demodulize.titleize,
                mapping: { index: 'not_analyzed' }
      attribute :url, String, mapping: { index: 'not_analyzed' }
    end
  end
end
