module ShowJSONSerializer
  def self.extended(base)
    base.module_eval do
      @attribute_mapping = {}
    end
    base.extend ModuleMethods
  end

  module ModuleMethods
    def serialize(resource)
      @attribute_mapping.each_with_object({}) do |(name, options), serialized|
        value = options[:method] ? resource.send(options[:method]) : resource.attributes[name]
        serialized[name] = value || options[:default]
      end
    end

    protected

    def attribute(name, options = {})
      @attribute_mapping[name] = options
    end
  end
end