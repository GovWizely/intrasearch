require 'trade_lead'

module ListAPI
  def self.extended(base)
    base.class_eval do
      list_module = base.name.demodulize.sub(/ListAPI\Z/, '').constantize

      params do
        optional :limit,
                 type: Integer,
                 values: 1..30
        optional :offset,
                 type: Integer,
                 regexp: /\A\d+\Z/
      end

      get "/#{list_module.name.tableize}" do
        list_module.all declared(params, include_missing: false)
      end
    end
  end
end
