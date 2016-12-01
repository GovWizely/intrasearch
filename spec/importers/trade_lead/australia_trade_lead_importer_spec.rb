require 'support/webservices_importer_shared_contexts'

RSpec.describe TradeLead::AustraliaTradeLeadImporter do
  describe '.import' do
    include_context 'webservices importer', Webservices::TradeLead

    it 'imports AUSTRALIA trade leads' do
      expected_attributes = {
        id: 'AUSTRALIA-62d753fee98294cab8d66d1bcb501cff1a4f6670',
        agency: 'Department of Industry, Innovation and Science',
        app_reference: '$app_reference',
        atm_id: 'PRI-00003629',
        atm_type: 'Request for Tender',
        click_url: '$click_url',
        conditions_for_participation: 'The tenderer and any subcontractors proposed in the tender must not be named as not complying with the Workplace Gender Equality Act 2012 (Cth).The tenderer confirms that in dealing with its employees and independent contractors, the tenderer has due regard to Commonwealth policies on the engagement of workers, comply with Commonwealth policies on the engagement of workers, including the obligations under the Work Health and Safety Act 2011 (Cth) and relevant work health and safety laws.The tenderer and any subcontractors proposed in the tender are not insolvent, bankrupt, in liquidation, or under administration or receivership.',
        contact_officer: 'Project Officer',
        countries: ['Australia'],
        delivery_timeframe: 'The anticipated timeframe for completing work under the contract is six months.',
        description: 'The Board of Innovation Australia (Board) is an independent statutory board charged with providing advice to government on all innovation, science and research matters. With the passage of legislation by the new parliament, Innovation Australia will change to become Innovation and Science Australia. The Office of Innovation and Science Australia (OISA) has been established within the Department of Industry, Innovation and Science (Department) to support the work of the Board. The Board is developing a long term strategic plan to maximise Australia’s innovation potential, positioning Australia to seize the next wave of economic prosperity and ensuring Australia’s wellbeing and economic growth in the future (Plan). To inform the Plan, the Board has commenced a performance audit (Audit) of Australia’s innovation, science and research system (System). The Audit will be delivered to government in December 2016 and will provide baseline data and analysis about the System.Accordingly, the Department invites suitably qualified consultants/contractors, including consortia to submit a tender for consultancy services.',
        email: 'email@example.au',
        end_at: DateTime.parse('2016-09-06T15:00:00+10:00'),
        expanded_industries: [
          'Franchising',
          'Information and Communication Technology',
          'Retail Trade',
          'eCommerce Industry'
        ],
        hosted_url: 'https://example.org/trade_lead?id=AUSTRALIA-62d753fee98294cab8d66d1bcb501cff1a4f6670',
        industries: [
          'Franchising',
          'eCommerce Industry'
        ],
        industry_paths: [
          '/Franchising',
          '/Information and Communication Technology/eCommerce Industry',
          '/Retail Trade/eCommerce Industry'
        ],
        location: 'ACT',
        lodgement_address: 'Tenderers must be lodged electronically using AusTender',
        multi_agency_access: '$multi_agency_access',
        other_instructions: '$other_instructions',
        panel_arrangement: '$panel_arrangement',
        phone: '$phone',
        published_at: DateTime.parse('2016-08-12T00:00:00+10:00'),
        source: 'AUSTRALIA',
        title: 'Professional Advice on Innovation System Strategic Planning',
        url: 'https://www.tenders.gov.au/?event=public.ATM.show&ATMUUID=B15D8DFA-08DD-A7F1-9A4525609F5D3337',
        trade_regions: [
          'Asia Pacific Economic Cooperation',
          'Trans Pacific Partnership'
        ],
        world_region_paths: [
          '/Asia Pacific',
          '/Oceania',
          '/Pacific Rim'
        ],
        world_regions: [
          'Asia Pacific',
          'Oceania',
          'Pacific Rim'
        ]
      }

      described_class.import
      expect(model_class.count).to eq(1)
      expect(model_class.all.first).to have_attributes(expected_attributes)
    end
  end
end
