namespace :intrasearch do
  desc 'setup indices'
  task setup_indices: :environment do
    TemplateLoader.new.load
    IndexManager.setup_indices
  end

  desc 'import taxonomies'
  task import_taxonomies: :environment do
    [TradeRegionImporter,
     CountryImporter,
     IndustryImporter,
     TopicImporter].each do |klass|
      klass.new.import
    end
  end

  desc 'import articles'
  task import_articles: :environment do
    ArticleImporter.subclasses.each do |klass|
      klass.new.import
    end
  end
end
