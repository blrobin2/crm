RSpec.describe 'ResponseBuilder' do
  let(:resource) { create_list(:user, 3) }
  let(:params) { ActionController::Parameters.new(fields: { 'users' => 'first_name,last_name' }) }
  let(:response_builder) { ResponseBuilder.new(resource, params) }

  describe '#fields' do
    it 'builds a field list for the serializer' do
      expect(response_builder.fields).to eq({ users: [:first_name, :last_name] })
    end
  end
end
