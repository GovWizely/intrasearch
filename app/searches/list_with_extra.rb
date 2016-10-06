module ListWithExtra
  def self.included(base)
    base.include InstanceMethods

    class << base
      attr_accessor :extra_model_class,
                    :query_class,
                    :repository_class,
                    :response_class
    end

    base.class_eval do
      attr_reader :limit, :offset
    end
  end

  module InstanceMethods
    DEFAULT_OFFSET = 0
    DEFAULT_LIMIT = 30

    def initialize(options)
      @limit = options[:limit] || DEFAULT_LIMIT
      @offset = options[:offset] || DEFAULT_OFFSET
    end

    def run
      repository = self.class.repository_class.new
      results = repository.search build_query
      assign_extras results
      self.class.response_class.new self, results
    end

    private

    def build_query
      self.class.query_class.new limit: @limit,
                                 offset: @offset
    end


    def assign_extras(results)
      ids = results.results.map(&:id)
      return if ids.blank?

      extras = self.class.extra_model_class.find ids
      results.results.each_with_index do |result, index|
        extra = extras[index] || self.class.extra_model_class.new
        result.instance_variable_set :@extra, extra
      end
    end
  end
end