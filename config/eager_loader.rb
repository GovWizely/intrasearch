module Intrasearch
  module EagerLoader
    def self.load(path, in_load_path)
      Dir[File.join(path, '*.rb')].each do |f|
        f = File.basename(f, '.rb') if in_load_path
        require f
      end
    end
  end
end
