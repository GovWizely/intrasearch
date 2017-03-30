require 'rake'

RSpec.describe 'intrasearch.rake' do
  before(:all) do
    @rake = Rake::Application.new
    Rake.application = @rake
    Rake.application.rake_require('tasks/intrasearch')
    Rake::Task.define_task(:environment)
  end

  describe 'intrasearch:setup_indices' do
    it 'setups indices' do
      template_loader = instance_double TemplateLoader
      expect(TemplateLoader).to receive(:new).and_return(template_loader)
      expect(template_loader).to receive(:load)
      expect(IndexManager).to receive(:setup_indices)

      @rake['intrasearch:setup_indices'].invoke
    end
  end

  describe 'intrasearch:import_taxonomies' do
    it 'imports taxonomies' do
      expect(TradeRegionImporter).to receive(:import).ordered
      expect(WorldRegionImporter).to receive(:import).ordered
      expect(CountryImporter).to receive(:import).ordered
      expect(IndustryImporter).to receive(:import)
      expect(TopicImporter).to receive(:import)

      @rake['intrasearch:import_taxonomies'].invoke
    end
  end

  describe 'intrasearch:import_articles' do
    it 'imports articles' do
      expect(ArticleImporter).to receive(:import)
      expect(BasicGuideToExportingImporter).to receive(:import)
      expect(CountryCommercialGuideImporter).to receive(:import)
      expect(FaqImporter).to receive(:import)
      expect(MarketInsightImporter).to receive(:import)
      expect(MarketIntelligenceImporter).to receive(:import)
      expect(StateReportImporter).to receive(:import)
      expect(TopMarketsReportImporter).to receive(:import)

      @rake['intrasearch:import_articles'].invoke
    end
  end

  describe 'intrasearch:import_trade_events' do
    it 'imports trade events' do
      expect(TradeEvent::DlTradeEventImporter).to receive(:import)
      expect(TradeEvent::ItaTradeEventImporter).to receive(:import)
      expect(TradeEvent::SbaTradeEventImporter).to receive(:import)
      expect(TradeEvent::UstdaTradeEventImporter).to receive(:import)
      expect(TradeEvent).to receive(:ids).and_return(%w(foo bar))
      expect(TradeEvent::Extra).to receive(:prune_obsolete_documents).with(%w(foo bar))

      @rake['intrasearch:import_trade_events'].invoke
    end
  end

  describe 'intrasearch:import_trade_leads' do
    it 'imports trade leads' do
      expect(TradeLead::AustraliaTradeLeadImporter).to receive(:import)
      expect(TradeLead::CanadaTradeLeadImporter).to receive(:import)
      expect(TradeLead::FboTradeLeadImporter).to receive(:import)
      expect(TradeLead::McaTradeLeadImporter).to receive(:import)
      expect(TradeLead::StateTradeLeadImporter).to receive(:import)
      expect(TradeLead::UkTradeLeadImporter).to receive(:import)
      expect(TradeLead::UstdaTradeLeadImporter).to receive(:import)
      expect(TradeLead).to receive(:ids).and_return(%w(foo bar))
      expect(TradeLead::Extra).to receive(:prune_obsolete_documents).with(%w(foo bar))

      @rake['intrasearch:import_trade_leads'].invoke
    end
  end

  describe 'intrasearch:import_web_documents' do
    it 'imports web documents' do
      expect(WebDocumentImporter).to receive(:import)

      @rake['intrasearch:import_web_documents'].invoke
    end
  end
end
