module Intrasearch
  def self.eager_load(base_pattern, file_pattern = '*.rb', in_load_path = true)
    Dir[base_pattern].each do |base_path|
      Dir.chdir(base_path) do
        Dir[file_pattern].each do |f|
          in_load_path ? require(f) : require_relative(f)
        end
      end
    end
  end
end
