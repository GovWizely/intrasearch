require 'support/api_shared_contexts'
require 'support/api_shared_examples'
require 'support/api_spec_helpers'
require 'support/elastic_model_shared_contexts'

RSpec.describe TradeLeadFindByIdAPI do
  include APISpecHelpers

  include_context 'elastic models',
                  TradeLead::AustraliaTradeLead,
                  TradeLead::CanadaTradeLead,
                  TradeLead::Extra,
                  TradeLead::FboTradeLead,
                  TradeLead::McaTradeLead,
                  TradeLead::StateTradeLead,
                  TradeLead::UkTradeLead,
                  TradeLead::UstdaTradeLead

  describe 'get AUSTRALIA trade lead by id' do
    before { get '/v1/trade_leads/AUSTRALIA-62d753fee98294cab8d66d1bcb501cff1a4f6670' }

    include_context 'API response'

    it_behaves_like 'a successful API response'

    it 'returns AUSTRALIA trade lead attributes' do
      expected_attributes = {
        id: 'AUSTRALIA-62d753fee98294cab8d66d1bcb501cff1a4f6670',
        agency: 'Department of Industry, Innovation and Science',
        app_reference: '$app_reference',
        atm_id: 'PRI-00003629',
        atm_type: 'Request for Tender',
        click_url: '$click_url',
        conditions_for_participation: 'The tenderer and any subcontractors proposed in the tender must not be named as not complying with the Workplace Gender Equality Act 2012 (Cth).The tenderer confirms that in dealing with its employees and independent contractors, the tenderer has due regard to Commonwealth policies on the engagement of workers, comply with Commonwealth policies on the engagement of workers, including the obligations under the Work Health and Safety Act 2011 (Cth) and relevant work health and safety laws.The tenderer and any subcontractors proposed in the tender are not insolvent, bankrupt, in liquidation, or under administration or receivership.',
        contact_officer: 'Project Officer',
        country: 'Australia',
        delivery_timeframe: 'The anticipated timeframe for completing work under the contract is six months.',
        description: 'The Board of Innovation Australia (Board) is an independent statutory board charged with providing advice to government on all innovation, science and research matters. With the passage of legislation by the new parliament, Innovation Australia will change to become Innovation and Science Australia. The Office of Innovation and Science Australia (OISA) has been established within the Department of Industry, Innovation and Science (Department) to support the work of the Board.',
        email: 'email@example.au',
        end_at: '2016-09-06T15:00:00+10:00',
        hosted_url: 'https://example.org/trade_lead?id=AUSTRALIA-62d753fee98294cab8d66d1bcb501cff1a4f6670',
        industries: [
          'eCommerce Industry'
        ],
        location: 'ACT',
        lodgement_address: 'Tenderers must be lodged electronically using AusTender',
        multi_agency_access: '$multi_agency_access',
        other_instructions: '$other_instructions',
        panel_arrangement: '$panel_arrangement',
        phone: '$phone',
        published_at: '2016-08-12T00:00:00+10:00',
        source: 'AUSTRALIA',
        title: 'Lead Professional Advice on Innovation System Strategic Planning',
        url: 'https://www.tenders.gov.au/?event=public.ATM.show&ATMUUID=B15D8DFA-08DD-A7F1-9A4525609F5D3337'
      }
      expect(parsed_body).to eq(expected_attributes)
    end
  end

  describe 'get CANADA trade lead by id' do
    before { get '/v1/trade_leads/CANADA-539d317fe76effc1e7631ce1a7d2e6b814434f51' }

    include_context 'API response'

    it_behaves_like 'a successful API response'

    it 'returns CANADA trade lead attributes' do
      expected_attributes = {
        id: 'CANADA-539d317fe76effc1e7631ce1a7d2e6b814434f51',
        amended_at: '2016-08-11T00:00:00+00:00',
        amendment_number: '000',
        bid_type: 'All interested suppliers may submit a bid',
        click_urls: %w(https://goo.gl/canada1 https://goo.gl/canada2),
        competitive_procurement_strategy: 'N/A',
        contact: 'Jane Doe',
        contract_number: '47419-188062/B',
        country: 'Canada',
        description: '<h2>Awesome description.</h2>',
        end_at: '2016-09-20T00:00:00+00:00',
        hosted_url: 'https://example.org/trade_lead?id=CANADA-539d317fe76effc1e7631ce1a7d2e6b814434f51',
        implementing_entity: 'Canada Border Services Agency',
        industries: [
          'Franchising',
          'eCommerce Industry'
        ],
        notice_type: 'APM-NPP',
        procurement_organization: 'Public Works and Government Services Canada',
        published_at: '2016-08-10T00:00:00+00:00',
        publishing_status: 'Active',
        reference_number: 'PW-$$BK-379-25940',
        source: 'CANADA',
        specific_location: 'Alberta',
        title: 'Awesome Lead',
        trade_agreement: 'World Trade Organization-Agreement',
        urls: [
          'https://tradelead.example.org/canada/1%20with%20spaces.pdf',
          'https://tradelead.example.org/canada/2.pdf'
        ]
      }
      expect(parsed_body).to eq(expected_attributes)
    end
  end

  describe 'get FBO trade lead by id' do
    before { get '/v1/trade_leads/FBO-995a1c55b26d11fe162f3f61b594be8c403c60f0' }

    include_context 'API response'

    it_behaves_like 'a successful API response'

    it 'returns FBO trade lead attributes' do
      expected_attributes = {
        id: 'FBO-995a1c55b26d11fe162f3f61b594be8c403c60f0',
        classification_code: 'U',
        click_url: 'https://goo.gl/fbo1',
        competitive_procurement_strategy: '$competitive_procurement_strategy',
        contact: 'Jane Doe',
        contract_number: 'sol-674-14-000014',
        country: 'South Africa',
        description: '<h3>See RFP.</h3>',
        end_at: '2017-04-17T00:00:00+00:00',
        hosted_url: 'https://example.org/trade_lead?id=FBO-995a1c55b26d11fe162f3f61b594be8c403c60f0',
        industries: [
          'Scientific and Technical Services'
        ],
        notice_type: 'COMBINE',
        procurement_office: 'Overseas Missions',
        procurement_office_address: 'Dept of State Washington DC 20521-6120',
        procurement_organization: 'Agency for International Development',
        procurement_organization_address: 'South Africa USAID-Pretoria',
        published_at: '2014-03-03T00:00:00+00:00',
        source: 'FBO',
        specific_address: 'Regional Acquisition and Assistance Office',
        title: 'Education Activity Lead',
        url: 'https://www.fbo.org/url%20with%20spaces.html'
      }

      expect(parsed_body).to eq(expected_attributes)
    end
  end

  describe 'get MCA trade lead by id' do
    before { get '/v1/trade_leads/MCA-f3a40a7987cd049cbf093079bbef65b1df387d00' }

    include_context 'API response'

    it_behaves_like 'a successful API response'

    it 'returns MCA trade lead attributes' do
      expected_attributes = {
        id: 'MCA-f3a40a7987cd049cbf093079bbef65b1df387d00',
        categories: [
          'type/spn',
          'CPV/30236000',
          'CPV/30000000',
          'deadline/2017/Jun/09'
        ],
        click_url: 'http://goo.gl/mca1',
        country: 'South Africa',
        description: '<h3>MILLENNIUM CHALLENGE ACCOUNT BENIN II.</h3>',
        funding_source: 'Millennium Challenge Account (MCA)',
        hosted_url: 'https://example.org/trade_lead?id=MCA-f3a40a7987cd049cbf093079bbef65b1df387d00',
        source: 'MCA',
        published_at: '2016-06-18T21:10:41-04:00',
        title: 'Purchase of Computer Equipment Lead',
        url: 'http://www.dgmarket.com/tenders/np-notice.do?noticeId=14114655'
      }

      expect(parsed_body).to eq(expected_attributes)
    end
  end

  describe 'get STATE trade lead by id' do
    before { get '/v1/trade_leads/STATE-c118cb6ed4345bb33980b2dfb77303e2a561866a' }

    include_context 'API response'

    it_behaves_like 'a successful API response'

    it 'returns STATE trade lead attributes' do
      expected_attributes = {
        id: 'STATE-c118cb6ed4345bb33980b2dfb77303e2a561866a',
        borrowing_entity: 'Not Applicable',
        click_url: 'http://goo.gl/state1',
        comments: 'The value stated is not the correct value it is only for uploading purposes.',
        contact: 'NSB Fund Management',
        country: 'Taiwan',
        description: 'Expression of Interest',
        end_at: '2016-08-24T00:00:00+00:00',
        funding_source: 'Other',
        hosted_url: 'https://example.org/trade_lead?id=STATE-c118cb6ed4345bb33980b2dfb77303e2a561866a',
        lead_source: 'Post Identified Project',
        industries: ['Retail Trade'],
        procurement_organization: 'Ministry of Transport and Civil Aviation',
        project_number: 'NSB/SL/1601',
        project_size: 3240000000,
        published_at: '2016-07-06T00:00:00+00:00',
        record_id: 'DATATABLE.1667',
        source: 'STATE',
        specific_location: 'Western Province',
        status: 'Pipeline',
        submitting_officer: 'Jane Doe',
        submitting_officer_contact: 'jane@example.org',
        tags: ['A tag with extra spaces'],
        title: 'Taiwan Lead',
        url: 'http://www.example.org/state'
      }

      expect(parsed_body).to eq(expected_attributes)
    end
  end

  describe 'get UK trade lead by id' do
    before { get '/v1/trade_leads/UK-d292a188d7ce8dd13419de8c0da4ce7b29c79899' }

    include_context 'API response'

    it_behaves_like 'a successful API response'

    it 'returns UK trade lead attributes' do
      expected_attributes = {
        id: 'UK-d292a188d7ce8dd13419de8c0da4ce7b29c79899',
        click_url: 'http://goo.gl/uk1',
        contact: 'john@example.co.uk',
        contract_end_at: '2022-03-13T00:00:00+00:00',
        contract_start_at: '2017-03-14T00:00:00+00:00',
        country: 'United Kingdom',
        deadline_at: '2016-09-19T00:00:00+00:00',
        description: 'UK Business Services',
        hosted_url: 'https://example.org/trade_lead?id=UK-d292a188d7ce8dd13419de8c0da4ce7b29c79899',
        industries: ['Space'],
        max_contract_value: 6000000.0,
        min_contract_value: 0.0,
        notice_type: 'Contract',
        procurement_organization: 'UK BUSINESS',
        published_at: '2016-08-15T09:21:36+00:00',
        record_id: '355c8432-d59c-46d4-bd3e-015e3fd9fdd4',
        reference_number: 'PR16098',
        source: 'UK',
        specific_location: 'Any region',
        status: 'Open',
        title: 'Advanced Electron Microscopy Lead',
        url: 'http://www.example.co.uk/'
      }

      expect(parsed_body).to eq(expected_attributes)
    end
  end

  describe 'get USTDA trade lead by id' do
    before { get '/v1/trade_leads/USTDA-26252346bf5f16c1a9a9b2dfa2762bbe2c99b8ae' }

    include_context 'API response'

    it_behaves_like 'a successful API response'

    it 'returns USTDA trade lead attributes' do
      expected_attributes = {
        id: 'USTDA-26252346bf5f16c1a9a9b2dfa2762bbe2c99b8ae',
        click_url: 'https://goo.gl/ustda1',
        country: 'South Africa',
        description: 'Background: a South African state-owned freight logistics company',
        end_at: '2016-09-30T00:00:00+00:00',
        hosted_url: 'https://example.org/trade_lead?id=USTDA-26252346bf5f16c1a9a9b2dfa2762bbe2c99b8ae',
        published_at: '2016-06-13T00:00:00+00:00',
        source: 'USTDA',
        title: 'Trade Lead: South Africa: Global Logistics Service Provider',
        url: 'https://www.example.org/ustda'
      }

      expect(parsed_body).to eq(expected_attributes)
    end
  end
end
