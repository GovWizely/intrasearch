require 'base_model'

module ExtraModel
  def self.included(base)
    base.include ::BaseModel
    base.include InstanceMethods
    base.extend ClassMethods

    base.class_eval do
      append_index_namespace base.parent.name.tableize,
                             base.name.demodulize.tableize

      attribute :md_description, String, mapping: { index: 'not_analyzed' }
      attribute :html_description, String, mapping: { index: 'not_analyzed' }

      validates :id, presence: true

      before_save :nullify_blank_attributes
    end
  end

  module ClassMethods
    def prune_obsolete_documents(parent_ids)
      return unless parent_ids.present?

      obsolete_extra_ids = ids - parent_ids
      delete_by_ids obsolete_extra_ids
    end

    def delete_by_ids(document_ids)
      return unless document_ids.present?

      client = Elasticsearch::Client.new

      document_ids.each_slice(1000) do |slice_of_ids|
        bulk_queries = slice_of_ids.map { |id| { delete: { _id: id } } }
        client.bulk index: index_name,
                    body: bulk_queries,
                    type: document_type
      end

      gateway.refresh_index!
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
