module AttributeMappingBuilder
  module ModuleMethods
    def build(name, options = {})
      options[:attributes] &&= process_attributes options[:attributes]
      options[:key] ||= name.to_s
      { name => options }
    end

    private

    def process_attributes(attributes)
      return {} if attributes.empty?
      attributes.each_with_object({}) do |attribute, result|
        case attribute
        when Symbol
          result.merge! build(attribute)
        when Hash
          name, options = attribute.to_a.first
          result.merge! build(name, options)
        end
      end
    end
  end

  extend ModuleMethods
end
