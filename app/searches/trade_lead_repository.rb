require 'repository'
require 'trade_lead/australia_trade_lead'
require 'trade_lead/canada_trade_lead'
require 'trade_lead/fbo_trade_lead'
require 'trade_lead/mca_trade_lead'
require 'trade_lead/state_trade_lead'
require 'trade_lead/uk_trade_lead'
require 'trade_lead/ustda_trade_lead'

class TradeLeadRepository < Repository
  MODELS = [
    TradeLead::AustraliaTradeLead,
    TradeLead::CanadaTradeLead,
    TradeLead::FboTradeLead,
    TradeLead::McaTradeLead,
    TradeLead::StateTradeLead,
    TradeLead::UkTradeLead,
    TradeLead::UstdaTradeLead
  ].freeze

  def initialize
    super(*MODELS)
  end

  private

  def get_klass_from_type(type)
    klass = "trade_lead/#{type}".classify
    klass.constantize
  end
end
