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
      tr_importer = instance_double TradeRegionImporter
      expect(TradeRegionImporter).to receive(:new) { tr_importer }
      expect(tr_importer).to receive(:import)

      expect(TaxonomyImporter).to receive(:subclasses) { [IndustryImporter] }
      importer = instance_double IndustryImporter
      expect(IndustryImporter).to receive(:new) { importer }
      expect(importer).to receive(:import)

      @rake['intrasearch:import_taxonomies'].invoke
    end
  end

  describe 'intrasearch:import_articles' do
    it 'imports articles' do
      expect(ArticleImporter).to receive(:subclasses) { [GenericImporter] }
      importer = instance_double GenericImporter
      expect(GenericImporter).to receive(:new) { importer }
      expect(importer).to receive(:import)

      @rake['intrasearch:import_articles'].invoke
    end
  end
end
