require 'rails_helper'

RSpec.describe UserSerializer do
  describe 'serialization' do
    let(:user) { create(:user) }
    let(:serializer) { described_class.new(user) }
    let(:actual) { JSON.parse(serializer.to_json) }

    it 'serializes the user attributes' do
      attributes = actual['data']['attributes']
      expect(attributes).to have_keys('first_name', 'last_name', 'email')
    end

    it 'defines the type' do
      expect(actual['data']['type']).to eq('users')
    end
  end
end
