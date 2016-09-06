require 'active_support/core_ext/hash/except'

require 'trade_event_transformer'

module UstdaTradeEventTransformer
  extend TradeEventTransformer
  CONTACT_ATTRIBUTES = %i(
    email first_name last_name person_title phone post
  ).freeze

  def self.transform(attributes)
    contact_attributes = attributes.extract!(*CONTACT_ATTRIBUTES)
    attributes[:contacts] = [contact_attributes] if contact_attributes.values.compact.present?
    super
  end
end
