class FindByIdQuery
  def initialize(id)
    @id = id
  end

  def to_hash
    {
      query: {
        ids: {
          values: [@id]
        }
      }
    }
  end
end
