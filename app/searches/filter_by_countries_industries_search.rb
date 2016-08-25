require 'search'

module FilterByCountriesIndustriesSearch
  def self.included(base)
    class << base
      attr_accessor :repository_class,
                    :search_response_class,
                    :query_class
    end

    base.include Search
    base.include InstanceMethods
  end

  module InstanceMethods
    def initialize(options)
      super
      @countries = options[:countries].to_s.split(',')
      @industries = options[:industries].to_s.split(',')
    end

    def run
      repository = self.class.repository_class.new
      results = repository.search build_query
      self.class.search_response_class.new self, results
    end

    def build_query
      self.class.query_class.new countries: @countries,
                                 industries: @industries,
                                 limit: @limit,
                                 offset: @offset,
                                 q: @q
    end
  end
end
