require 'base_model'

module TradeEvent
  class TradeEventExtra
    include ::BaseModel

    append_index_namespace parent.name.tableize,
                           name.demodulize.tableize

    attribute :md_description, String, mapping: { index: 'not_analyzed' }
    attribute :html_description, String, mapping: { index: 'not_analyzed' }

    validates :id, presence: true

    before_save :nullify_blank_attributes

    private

    def nullify_blank_attributes
      self.md_description = nil if md_description.blank?
      self.html_description = nil if html_description.blank?
    end
  end
end
