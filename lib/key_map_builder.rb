module KeyMapBuilder
  module ModuleMethods
    def build(keys_options)
      keys_options.each_with_object({}) do |(key, options), key_map|
        key_map[key] = build_key_options key, options
      end
    end

    private

    def build_key_options(key, options)
      options ||= {}
      options[:attributes] &&= build options[:attributes]
      options[:source_key] ||= key.to_s
      options
    end
  end

  extend ModuleMethods
end
