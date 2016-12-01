module ModelIdsCollector
  def self.collect(*models)
    models.map do |model|
      model.ids
    end.flatten
  end
end