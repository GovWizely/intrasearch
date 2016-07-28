require 'base_article_search_query'
require 'base_article_search_response'
require 'repository'
require 'search'

module BaseArticleSearch
  def self.included(base)
    base.include Search
    base.include InstanceMethods

    class << base
      attr_accessor :query_class,
                    :search_response_class
    end
    base.query_class = BaseArticleSearchQuery
    base.search_response_class = BaseArticleSearchResponse
  end

  module InstanceMethods
    def initialize(options)
      super
      @countries = options[:countries].to_s.split(',')
      @industries = options[:industries].to_s.split(',')
      @topics = options[:topics].to_s.split(',')
      @trade_regions = options[:trade_regions].to_s.split(',')
      @types = options[:types]
      @world_regions = options[:world_regions].to_s.split(',')
    end

    def run
      repository = Repository.new(*@types)
      results = repository.search build_query
      self.class.search_response_class.new self, results
    end

    def build_query
      self.class.query_class.new query_params
    end

    def query_params
      {
        countries: @countries,
        industries: @industries,
        limit: @limit,
        offset: @offset,
        q: @q,
        topics: @topics,
        trade_regions: @trade_regions,
        world_regions: @world_regions
      }
    end
  end
end
