require 'uri'

class ArticleTransformer
  URL_PREFIX = YAML.load(File.read(Nix.root.join('config/intrasearch.yml')))[Nix.env]['article_url_prefix'].freeze

  def transform(attributes)
    transform_countries attributes
    transform_industries attributes
    transform_topics attributes
    transform_url_name attributes
    attributes
  end

  protected

  def transform_countries(attributes)
    valid_countries = CountrySearch.new(attributes[:geographies]).run
    attributes[:countries] = valid_countries.map(&:label).sort
    attributes
  end

  def transform_industries(attributes)
    valid_industries = IndustrySearch.new(attributes[:industries]).run
    attributes[:industries] = valid_industries.map(&:label).sort
    attributes[:industry_paths] = valid_industries.map(&:path).sort
    attributes
  end

  def transform_topics(attributes)
    topics = attributes.delete(:trade_topics) || []
    valid_topics = TopicSearch.new(topics).run
    attributes[:topic_paths] = valid_topics.map(&:path).sort
    attributes[:topics] = valid_topics.map(&:label).sort
    attributes
  end

  def transform_url_name(attributes)
    if attributes[:url_name].present?
      attributes[:url] = "#{URL_PREFIX}#{URI.encode_www_form_component(attributes[:url_name])}"
    end
    attributes
  end
end
