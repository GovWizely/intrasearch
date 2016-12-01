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

  desc 'import trade events'
  task import_trade_events: :environment do
    TradeEvent::TradeEventImporter.descendants.each(&:import)
    TradeEvent::Extra.prune_obsolete_documents TradeEvent.ids
  end

  desc 'import trade leads'
  task import_trade_leads: :environment do
    TradeLead::TradeLeadImporter.descendants.each(&:import)
    TradeLead::Extra.prune_obsolete_documents TradeLead.ids
  end

  desc 'import web documents'
  task import_web_documents: :environment do
    WebDocumentImporter.import
  end

  desc 'import all types of content'
  task import_all: %i(import_taxonomies import_trade_events import_trade_leads import_web_documents import_articles)
end
