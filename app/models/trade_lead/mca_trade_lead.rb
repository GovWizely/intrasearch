require 'trade_lead/base_model'

module TradeLead
  class McaTradeLead
    include BaseModel

    not_analyzed_attributes String,
                            :categories,
                            :click_url,
                            :funding_source,
                            :url
  end
end
