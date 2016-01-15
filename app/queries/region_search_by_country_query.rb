class RegionSearchByCountryQuery
  def initialize(countries)
    @countries = countries.map { |l| l.downcase.squish }
  end

  def to_hash
    {
      query: {
        filtered: {
          query: {
            terms: {
              countries: @countries
            }
          }
        }
      }
    }
  end
end
