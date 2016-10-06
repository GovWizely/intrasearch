require 'base_model'

module ExtraModel
  def self.included(base)
    base.include ::BaseModel
    base.include InstanceMethods

    base.class_eval do
      append_index_namespace base.parent.name.tableize,
                             base.name.demodulize.tableize

      attribute :md_description, String, mapping: { index: 'not_analyzed' }
      attribute :html_description, String, mapping: { index: 'not_analyzed' }

      validates :id, presence: true

      before_save :nullify_blank_attributes
    end
  end

  module InstanceMethods
    private

    def nullify_blank_attributes
      self.md_description = nil if md_description.blank?
      self.html_description = nil if html_description.blank?
    end
  end
end
