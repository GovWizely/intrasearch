require 'elasticsearch/persistence/model'

module BaseModel
  def self.included(base)
    base.class_eval do
      include Elasticsearch::Persistence::Model

      @base_index_namespace = ['intrasearch',
                               Intrasearch.env].join('-')
      @index_version = 'v1'

      extend ModuleMethods
    end

    class << base
      attr_reader :base_index_namespace,
                  :index_version
      attr_accessor :index_alias_name,
                    :index_name_prefix
    end
  end

  def self.model_classes
    Dir.chdir(Intrasearch.root.join('app/models')) do
      Dir['**/*.rb'].map do |f|
        klass = f.sub(/\.rb$/, '').classify.safe_constantize
        klass if klass.instance_of? Class
      end.compact
    end
  end

  module ModuleMethods
    def reset_index_name!
      self.index_name = index_alias_name
    end

    def ids
      find_in_batches(size: 10_000, _source_include: 'source').map do |b|
        b.results.map(&:id)
      end.flatten
    end

    protected

    def append_index_namespace(*namespaces)
      @index_namespace = [@base_index_namespace,
                          namespaces].join('-').freeze
      @index_name_prefix = [@index_namespace,
                            @index_version].join('-').freeze
      @index_alias_name = [@index_namespace,
                           'current'].join('-').freeze
      reset_index_name!
    end

    def analyzed_attributes(analyzer, *names)
      names.each do |name|
        attribute name, String, mapping: { analyzer: analyzer }
      end
    end

    def not_analyzed_attributes(*names)
      names.each do |name|
        attribute name, String, mapping: { index: 'not_analyzed' }
      end
    end

    def custom_attributes(type, *names)
      names.each do |name|
        attribute name, nil, mapping: { type: type }
      end
    end
  end
end
