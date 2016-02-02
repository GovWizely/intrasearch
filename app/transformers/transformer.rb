module Transformer
  def paths_to_labels(paths)
    paths.map do |path|
      path.split('/').reject(&:blank?)
    end.flatten.compact.uniq.sort
  end
end
