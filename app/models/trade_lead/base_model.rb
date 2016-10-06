require 'active_support/core_ext/string/inflections'
require 'forwardable'

require 'base_model'
require 'model_with_extra'
require 'trade_lead/extra'

module TradeLead
  module BaseModel
    def self.included(base)
      base.include ::BaseModel
      base.extend ModuleMethods
      base.include InstanceMethods
      base.include ModelWithExtra

      base.extend Forwardable
      base.def_delegators :extra, :md_description, :html_description

      base.class_eval do
        append_index_namespace parent.name.tableize,
                               name.demodulize.tableize

        analyzed_attributes 'english_analyzer',
                            :original_description,
                            :title

        not_analyzed_attributes :countries,
                                :hosted_url,
                                :source,
                                :trade_regions,
                                :world_regions

        attribute :world_region_paths, String, mapping: { analyzer: 'path_analyzer' }

        datetime_attributes :published_at

        validates_presence_of :hosted_url, :source, :title
      end
    end

    module ModuleMethods
      protected

      def datetime_attributes(*names)
        names.each do |name|
          attribute name,
                    DateTime,
                    mapping: {
                      format: 'strict_date_optional_time',
                      index: 'not_analyzed'
                    }
        end
      end
    end

    module InstanceMethods
      def attributes
        ActiveSupport::HashWithIndifferentAccess.new super
      end

      def country
        countries.first
      end
    end
  end
end
