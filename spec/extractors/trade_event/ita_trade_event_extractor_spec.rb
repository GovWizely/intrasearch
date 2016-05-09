RSpec.describe TradeEvent::ItaTradeEventExtractor do
  describe '.extract' do
    before do
      json = Intrasearch.root.join('spec/fixtures/json/webservices/ita_trade_events.json').read
      trade_events = JSON.parse(json)['results']
      expect(Webservices::TradeEvent).to receive(:all).
                                           with(sources: 'ITA').
                                           and_return(trade_events.to_enum)
    end

    it 'extracts trade events' do
      actual_trade_events = described_class.extract.to_a
      expected_trade_event = {
        id: '36282',
        cost: '4400.0',
        description: 'Event 36282 description',
        end_date: '2016-05-24',
        event_url: 'https://ita.trade.event.example.org/event/36282',
        industries: [
          'Franchising',
          'eCommerce Industry'
        ],
        name: 'Trade Event 36282',
        registration_title: 'Event 36282 title',
        registration_url: 'https://ita.trade.event.example.org/registration/36282',
        source: 'ITA',
        start_date: '2016-05-15',
        venues: [
          {
            country: 'United States',
            venue: 'Moscone Center, San Francisco'
          }
        ]
      }

      aggregate_failures do
        expect(actual_trade_events.count).to eq(1)
        expect(actual_trade_events.first).to eq(expected_trade_event)
      end
    end
  end
end
