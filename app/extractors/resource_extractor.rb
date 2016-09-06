require 'yaml'

require 'hash_extractor'

module ResourceExtractor
  def self.extended(base)
    class << base
      attr_accessor :keys_options_path,
                    :resource
    end

    base.extend ModuleMethods
  end

  module ModuleMethods
    def extract
      source = self.name.demodulize.tableize.split('_')[0].upcase
      results = resource.all sources: source
      Enumerator.new do |y|
        hash_extractor = hash_extractor_by_source source
        results.each do |result|
          y << hash_extractor.extract(source_hash: result)
        end
      end
    end

    protected

    def hash_extractor_by_source(source)
      yaml = Intrasearch.root.join(keys_options_path).read
      HashExtractor.new YAML.load(yaml)[source]
    end
  end
end
