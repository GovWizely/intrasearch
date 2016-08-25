RSpec.describe IndexManager do
  let(:client) { Elasticsearch::Persistence::Repository.new.client }
  let(:subject) { described_class.new(Country) }

  describe '#setup_new_index!' do
    context 'when there is an existing index' do
      before do
        expect(DateTime).to receive(:current).
                              and_return(DateTime.new(2015, 10, 11, 12, 13, 14),
                                         DateTime.new(2015, 10, 11, 15, 16, 17))
        subject.setup_new_index!
      end

      it 'creates new index' do
        expect(client.indices.exists? index: 'intrasearch-test-taxonomies-countries-v1-20151011_121314_000').to be true
        subject.setup_new_index!
        expect(client.indices.exists? index: 'intrasearch-test-taxonomies-countries-current').to be true
        expect(client.indices.exists? index: 'intrasearch-test-taxonomies-countries-v1-20151011_151617_000').to be true
        expect(subject.get_current_index_names).to eq(%w(intrasearch-test-taxonomies-countries-v1-20151011_151617_000))
        expect(client.indices.exists? index: 'intrasearch-test-taxonomies-countries-v1-20151011_121314_000').to be false
      end
    end

    context 'when the block raises an exception' do
      before do
        expect(DateTime).to receive(:current).
          and_return(DateTime.new(2015, 1, 11, 12, 13, 14),
                     DateTime.new(2015, 1, 11, 15, 16, 17))
        subject.setup_new_index!
      end

      it 'cleans up new index' do
        expect { subject.setup_new_index! { 1/0 } }.to raise_error(ZeroDivisionError)

        expect(client.indices.exists? index: 'intrasearch-test-taxonomies-countries-current').to be true
        expect(subject.get_current_index_names).to eq(%w(intrasearch-test-taxonomies-countries-v1-20150111_121314_000))
        expect(client.indices.exists? index: 'intrasearch-test-taxonomies-countries-v1-20150111_151617_000').to be false
      end
    end
  end

  describe '#setup_new_index_when_missing' do
    context 'when index is missing' do
      before do
        current_index_names = subject.get_current_index_names
        client.indices.delete index: current_index_names if current_index_names.present?
      end

      it 'creates new index' do
        subject.setup_new_index_when_missing
        expect(client.indices.exists? index: 'intrasearch-test-taxonomies-countries-current').to be true

        current_index_names = subject.get_current_index_names
        expect(current_index_names).to be_present
      end
    end

    context 'when index is present' do
      before { subject.setup_new_index! }

      it 'keeps existing index' do
        current_index_names = subject.get_current_index_names
        subject.setup_new_index_when_missing

        expect(client.indices.exists? index: 'intrasearch-test-taxonomies-countries-current').to be true
        expect(subject.get_current_index_names).to eq(current_index_names)
      end
    end

    context 'when an older version index is present' do
      let(:older_version_index_name_prefix) do
        ['intrasearch',
         Intrasearch.env,
         'taxonomies',
         'countries',
         'v0',
         'current'].join('-')
      end

      before { subject.setup_new_index! older_version_index_name_prefix }

      it 'creates new index' do
        current_index_names = subject.get_current_index_names
        subject.setup_new_index_when_missing

        expect(client.indices.exists? index: 'intrasearch-test-taxonomies-countries-current').to be true
        expect(subject.get_current_index_names).not_to eq(current_index_names)
      end
    end
  end

  describe '.setup_indices' do
    before { expect(BaseModel).to receive(:model_classes).and_return([Country]) }

    it 'setups new indices on each model class' do
      manager = instance_double IndexManager
      expect(IndexManager).to receive(:new).with(Country).and_return(manager)
      expect(manager).to receive(:setup_new_index_when_missing)
      described_class.setup_indices
    end
  end
end
