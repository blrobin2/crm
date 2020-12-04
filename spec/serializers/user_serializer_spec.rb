require 'rails_helper'

RSpec.describe UserSerializer do
  describe 'serialization' do
    let(:user) { create(:user) }
    let(:serializer) { described_class.new(user) }
    let(:actual) { JSON.parse(serializer.to_json) }
    let(:attributes) { actual['data']['attributes'] }

    it 'serializes the first name' do
      expect(attributes).to have_key('first_name')
    end

    it 'serializes the last name' do
      expect(attributes).to have_key('last_name')
    end

    it 'serializes the email' do
      expect(attributes).to have_key('email')
    end

    it 'defines the type' do
      expect(actual['data']['type']).to eq('users')
    end
  end
end
