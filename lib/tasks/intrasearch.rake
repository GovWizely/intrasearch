namespace :intrasearch do
  desc 'setup indices'
  task setup_indices: :environment do
    TemplateLoader.new.load
    IndexManager.setup_indices
  end

  desc 'import taxonomies'
  task import_taxonomies: :environment do
    [TradeRegionImporter,
     WorldRegionImporter,
     CountryImporter,
     IndustryImporter,
     TopicImporter].each(&:import)
  end

  desc 'import articles'
  task import_articles: :environment do
    BaseArticleImporter.descendants.each(&:import)
  end
end
