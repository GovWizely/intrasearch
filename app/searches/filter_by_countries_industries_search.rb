require 'search'

module FilterByCountriesIndustriesSearch
  def self.included(base)
    class << base
      attr_accessor :repository_class,
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
      repository.search build_query
    end

    def build_query
      self.class.query_class.new(**query_params)
    end

    protected

    def query_params
      {
        countries: @countries,
        industries: @industries,
        limit: @limit,
        offset: @offset,
        q: @q
      }
    end
  end
end
