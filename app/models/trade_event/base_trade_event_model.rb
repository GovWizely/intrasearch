require 'active_support/core_ext/string/inflections'

require 'base_model'

module TradeEvent
  module BaseTradeEventModel
    def self.included(base)
      base.include BaseModel

      base.module_eval do
        self.append_index_namespace parent.name.tableize,
                                    name.demodulize.tableize
      end
    end
  end
end
