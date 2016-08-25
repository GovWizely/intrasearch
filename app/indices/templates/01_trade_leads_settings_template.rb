require 'english_path_analyzers_template'

class TradeLeadsSettingsTemplate
  include EnglishPathAnalyzersTemplate

  def template_pattern
    ['intrasearch', Intrasearch.env, 'trade_leads', '*'].join('-')
  end
end
