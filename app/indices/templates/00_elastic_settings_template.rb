class ElasticSettingsTemplate
  def to_hash
    {
      template: template_pattern,
      settings: {
        number_of_replicas: 0,
        number_of_shards: 1
      }
    }
  end

  def template_pattern
    ['intrasearch', Intrasearch.env, '*'].join('-')
  end
end
