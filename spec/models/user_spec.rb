require 'support/elastic_model_shared_contexts'

RSpec.describe User do
  include_context 'elastic models',
                  User

  describe '.create' do
    context 'when case insensitive email already exists' do
      it 'add errors' do
        user = User.create email: 'ADMIN@example.org'
        expect(user.errors.full_messages).to eq(['Email has already been taken'])
      end
    end

    context 'when email is not present' do
      it 'add errors' do
        user = User.create email: nil
        expect(user.errors.full_messages).to eq(["Email can't be blank"])
      end
    end
  end
end
