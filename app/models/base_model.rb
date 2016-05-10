require 'elasticsearch/persistence/model'

module BaseModel
  def self.included(base)
    base.class_eval do
      include Elasticsearch::Persistence::Model

      class << self
        attr_accessor :index_alias_name,
                      :index_name_prefix

        def reset_index_name!
          self.index_name = index_alias_name
        end
      end
    end
  end

  def self.model_classes
    Dir[Intrasearch.root.join('app/models/*.rb')].map do |f|
      basename = File.basename f, '.rb'
      klass = basename.classify.safe_constantize
      klass if klass.instance_of? Class
    end.compact
  end
end
