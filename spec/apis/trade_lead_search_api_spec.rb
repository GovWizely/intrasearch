require 'support/api_shared_contexts'
require 'support/api_shared_examples'
require 'support/api_spec_helpers'
require 'support/elastic_model_shared_contexts'

RSpec.describe TradeLeadSearchAPI, endpoint: '/v1/trade_leads/search' do
  include APISpecHelpers

  include_context 'elastic models',
                  Country,
                  TradeLead::AustraliaTradeLead,
                  TradeLead::CanadaTradeLead,
                  TradeLead::Extra,
                  TradeLead::FboTradeLead,
                  TradeLead::McaTradeLead,
                  TradeLead::StateTradeLead,
                  TradeLead::UkTradeLead,
                  TradeLead::UstdaTradeLead,
                  TradeRegion,
                  WorldRegion

  include_context 'API response'

  context 'when searching with matching query term in the title' do
    before { get described_endpoint, 'q' => 'lead', 'limit' => 1 }

    it_behaves_like 'a successful API response'

    it 'returns metadata' do
      expect(parsed_body[:metadata]).to eq(total: 7,
                                           count: 1,
                                           offset: 0,
                                           next_offset: 1)
    end

    it 'returns countries aggregations' do
      expected_countries = [
        { key: 'Australia', doc_count: 1 },
        { key: 'Canada', doc_count: 1 },
        { key: 'South Africa', doc_count: 3 },
        { key: 'Taiwan', doc_count: 1 },
        { key: 'United Kingdom', doc_count: 1 }
      ]
      expect(parsed_body[:aggregations][:countries]).to eq(expected_countries)
    end

    it 'returns industries aggregation' do
      expected_industries = [
        { key: '/Aerospace and Defense', doc_count: 1 },
        { key: '/Aerospace and Defense/Space', doc_count: 1 },
        { key: '/Business and Professional Services', doc_count: 1 },
        { key: '/Business and Professional Services/Scientific and Technical Services', doc_count: 1 },
        { key: '/Franchising', doc_count: 2 },
        { key: '/Information and Communication Technology', doc_count: 2 },
        { key: '/Information and Communication Technology/eCommerce Industry', doc_count: 2 },
        { key: '/Retail Trade', doc_count: 3 },
        { key: '/Retail Trade/eCommerce Industry', doc_count: 2 }
      ]
      expect(parsed_body[:aggregations][:industries]).to eq(expected_industries)
    end

    it 'returns sources aggregation' do
      expected_sources = [
        { key: 'AUSTRALIA', doc_count: 1 },
        { key: 'CANADA', doc_count: 1 },
        { key: 'FBO', doc_count: 1 },
        { key: 'MCA', doc_count: 1 },
        { key: 'STATE', doc_count: 1 },
        { key: 'UK', doc_count: 1 },
        { key: 'USTDA', doc_count: 1 }
      ]
      expect(parsed_body[:aggregations][:sources]).to eq(expected_sources)
    end

    it 'highlights matching term in the title' do
      expected_first_result = {
        snippet: 'Awesome description.',
        title: 'Awesome <em>Lead</em>',
        url: 'https://example.org/trade_lead?id=CANADA-539d317fe76effc1e7631ce1a7d2e6b814434f51' }
      expect(parsed_body[:results].first).to eq(expected_first_result)
    end
  end

  context 'when searching with matching query term in the description' do
    before { get described_endpoint, 'q' => 'board', 'limit' => 1 }

    it_behaves_like 'a successful API response'

    it 'highlights matching term in the description' do
      expected_first_result = {
        snippet: 'The <em>Board</em> of Innovation Australia (<em>Board</em>) is an independent statutory '\
          '<em>board</em> charged with providing advice to government on all innovation, science and research matters. '\
          'With the passage of legislation by the new parliament, Innovation Australia ...',
        title: 'Lead Professional Advice on Innovation System Strategic Planning',
        url: 'https://example.org/trade_lead?id=AUSTRALIA-62d753fee98294cab8d66d1bcb501cff1a4f6670' }
      expect(parsed_body[:results].first).to eq(expected_first_result)
    end
  end

  context 'when searching with country name in the query' do
    before { get described_endpoint, 'q' => 'Canada', 'limit' => 1 }

    it_behaves_like 'a successful API response'

    it 'returns metadata' do
      expect(parsed_body[:metadata]).to eq(total: 1,
                                           count: 1,
                                           offset: 0,
                                           next_offset: nil)
    end

    it 'returns snippet, title and URL' do
      expected_first_result = {
        snippet: 'Awesome description.',
        title: 'Awesome Lead',
        url: 'https://example.org/trade_lead?id=CANADA-539d317fe76effc1e7631ce1a7d2e6b814434f51' }
      expect(parsed_body[:results].first).to eq(expected_first_result)
    end
  end

  context 'when searching with trade region name in the query' do
    before { get described_endpoint, 'q' => 'NAFTA', 'limit' => 1 }

    it_behaves_like 'a successful API response'

    it 'returns metadata' do
      expect(parsed_body[:metadata]).to eq(total: 1,
                                           count: 1,
                                           offset: 0,
                                           next_offset: nil)
    end

    it 'returns snippet, title and URL' do
      expected_first_result = {
        snippet: 'Awesome description.',
        title: 'Awesome Lead',
        url: 'https://example.org/trade_lead?id=CANADA-539d317fe76effc1e7631ce1a7d2e6b814434f51' }
      expect(parsed_body[:results].first).to eq(expected_first_result)
    end
  end

  context 'when searching with world region name in the query' do
    before { get described_endpoint, 'q' => 'North America', 'limit' => 1 }

    it_behaves_like 'a successful API response'

    it 'returns metadata' do
      expect(parsed_body[:metadata]).to eq(total: 1,
                                           count: 1,
                                           offset: 0,
                                           next_offset: nil)
    end

    it 'returns snippet, title and URL' do
      expected_first_result = {
        snippet: 'Awesome description.',
        title: 'Awesome Lead',
        url: 'https://example.org/trade_lead?id=CANADA-539d317fe76effc1e7631ce1a7d2e6b814434f51' }
      expect(parsed_body[:results].first).to eq(expected_first_result)
    end
  end

  context 'when filtering with countries' do
    before { get described_endpoint, 'countries' => 'Canada', 'limit' => 1 }

    it_behaves_like 'a successful API response'

    it 'returns metadata' do
      expect(parsed_body[:metadata]).to eq(total: 1,
                                           count: 1,
                                           offset: 0,
                                           next_offset: nil)
    end

    it 'returns unhighlighted title and snippet' do
      expected_first_result = {
        snippet: 'Awesome description.',
        title: 'Awesome Lead',
        url: 'https://example.org/trade_lead?id=CANADA-539d317fe76effc1e7631ce1a7d2e6b814434f51'
      }
      expect(parsed_body[:results].first).to eq(expected_first_result)
    end
  end

  context 'when filtering with industries' do
    before { get described_endpoint, 'industries' => 'Aerospace and Defense', 'limit' => 1 }

    it_behaves_like 'a successful API response'

    it 'returns metadata' do
      expect(parsed_body[:metadata]).to eq(total: 1,
                                           count: 1,
                                           offset: 0,
                                           next_offset: nil)
    end

    it 'returns unhighlighted title and snippet' do
      expected_first_result = {
        snippet: 'UK Business Services ...',
        title: 'Advanced Electron Microscopy Lead',
        url: 'https://example.org/trade_lead?id=UK-d292a188d7ce8dd13419de8c0da4ce7b29c79899'
      }
      expect(parsed_body[:results].first).to eq(expected_first_result)
    end
  end

  context 'when paginating with offset and limit' do
    before { get described_endpoint, 'q' => 'lead', 'limit' => 2, 'offset' => 1 }

    it_behaves_like 'a successful API response'

    it 'returns metadata' do
      expect(parsed_body[:metadata]).to eq(total: 7,
                                           count: 2,
                                           offset: 1,
                                           next_offset: 3)
    end
  end
end
