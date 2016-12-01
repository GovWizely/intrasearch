module NamespacedIdBySourceTransformer
  def transform_id(attributes)
    attributes[:id] &&= "#{attributes[:source]}-#{attributes[:id]}"
  end
end