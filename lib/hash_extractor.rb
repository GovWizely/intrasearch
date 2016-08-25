require 'sanitize'

require 'key_map_builder'

class HashExtractor
  def initialize(keys_options)
    @key_map = KeyMapBuilder.build keys_options
  end

  def extract(key_map: nil, source_hash:)
    key_map ||= @key_map
    key_map.each_with_object({}) do |(name, options), result_hash|
      result_hash[name] = extract_value options, source_hash[options[:source_key]]
    end
  end

  protected

  def extract_value(mapping_options, value)
    if value.is_a? Array
      extracted_value = extract_array_value mapping_options, value
    else
      extracted_value = sanitize_value mapping_options, value
    end
    extracted_value || mapping_options[:default]
  end

  def extract_array_value(mapping_options, array_value)
    if (mappings = mapping_options[:attributes])
      array_value.map do |source_hash|
        extract key_map: mappings, source_hash: source_hash
      end
    else
      array_value.map { |value| sanitize_value(mapping_options, value) }
    end
  end

  def sanitize_value(mapping_options, value)
    if value.present?
      if value.is_a? String
        mapping_options[:skip_sanitize] ? value.strip : Sanitize.fragment(value).squish
      else
        value
      end
    end
  end
end
