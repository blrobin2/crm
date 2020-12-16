describe 'GetTerritories' do
  include Docs::Api::V1::Territories::Api

  let(:territories) { create_list(:territories, 3) }
  let(:user) { create(:user) }
  let(:get_territories) do
    get '/api/v1/territories', headers: authenticated_headers(user)
  end

  context 'when user has not logged in' do
    include Docs::Api::V1::Territories::Index

    before do
      get '/api/v1/territories', headers: default_headers
    end

    it 'returns 401 status', :dox do
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when user has logged in' do
    include Docs::Api::V1::Territories::Index

    it 'returns 200 status', :dox do
      get_territories
      expect(response).to have_http_status(:ok)
    end
  end
end
