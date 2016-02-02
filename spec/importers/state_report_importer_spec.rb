require 'rack_helper'


RSpec.describe StateReportImporter do
  include_context 'shared elastic models',
                  Country,
                  Industry,
                  Topic

  describe '#import' do
    let(:extracted_args) do
      YAML.load Nix.root.join('spec/fixtures/yaml/extracted_state_reports.yml').read
    end

    before do
      expect(StateReportExtractor).to receive(:extract).and_return(extracted_args.to_enum)
    end

    it 'imports StateReport' do
      described_class.import
      expect(StateReport.count).to eq(1)

      expected_attributes = {
        id: 'ka5t0000000Kyl2AAC',
        atom: 'item 1 atom',
        countries: ['United States'],
        industries: ['Aerospace and Defense',
                     'Satellites',
                     'Space',
                     'Space Launch Equipment'],
        industry_paths: ['/Aerospace and Defense/Space/Satellites',
                         '/Aerospace and Defense/Space/Space Launch Equipment'],
        summary: nil,
        topic_paths: ['/Business Management',
                      '/Environment/Climate'],
        topics: ['Business Management',
                 'Climate',
                 'Environment'],
        title: 'item 1 title',
        url: 'https://example.org/article2?id=Space-Business',
      }
      item = StateReport.find(extracted_args[0][:id])
      expect(item).to have_attributes(expected_attributes)
    end
  end
end
