require 'trade_lead/base_model'

module TradeLead
  class UstdaTradeLead
    include BaseModel

    datetime_attributes :end_at

    not_analyzed_attributes :click_url,
                            :url
  end
end
