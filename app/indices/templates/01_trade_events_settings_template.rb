require 'english_path_analyzers_template'

class TradeEventsSettingsTemplate
  include EnglishPathAnalyzersTemplate

  def template_pattern
    ['intrasearch', Intrasearch.env, 'trade_events', '*'].join('-')
  end
end
