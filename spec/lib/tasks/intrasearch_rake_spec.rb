require 'rack_helper'
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
      expect(CountryCommercialGuideImporter).to receive(:import)
      expect(MarketInsightImporter).to receive(:import)
      expect(StateReportImporter).to receive(:import)
      expect(TopMarketsReportImporter).to receive(:import)

      @rake['intrasearch:import_articles'].invoke
    end
  end
end
