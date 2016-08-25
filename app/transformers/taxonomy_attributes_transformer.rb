require 'country'
require 'industry'

module TaxonomyAttributesTransformer
  def transform_countries_and_regions(attributes, countries)
    valid_countries = Country.search_by_labels(*countries)
    attributes[:countries] = valid_countries.map(&:label).sort
    attributes[:trade_regions] = valid_countries.map(&:trade_regions).flatten.uniq.sort
    attributes[:world_region_paths] = valid_countries.map(&:world_region_paths).flatten.uniq.sort
    attributes[:world_regions] = valid_countries.map(&:world_regions).flatten.uniq.sort
  end

  def transform_industries(attributes, name = :industries)
    transform_taxonomies Industry, attributes, name
  end

  def transform_taxonomies(klass, attributes, name)
    taxonomies = klass.search_by_labels(*attributes[name])
    paths = taxonomies.map(&:path).uniq.sort
    attributes["#{klass.name.downcase}_paths"] = paths
    attributes[name] = paths_to_labels paths
  end

  def paths_to_labels(paths)
    paths.map do |path|
      path.split('/').reject(&:blank?)
    end.flatten.compact.uniq.sort
  end
end
