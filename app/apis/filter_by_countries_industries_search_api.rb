require 'shared_params'

module FilterByCountriesIndustriesSearchAPI
  def self.extended(base)
    base.class_eval do
      helpers SharedParams

      params do
        use :full_text_search_with_countries_and_industries,
            :pagination
      end
    end
  end
end
