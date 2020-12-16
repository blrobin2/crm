describe 'GetUsers' do
  include Docs::Api::V1::Users::Api
  let(:users) { create_list(:user, 3) }
  let(:user) { create(:user) }
  let(:get_users) { get '/api/v1/users', headers: authenticated_headers(user) }

  context 'when user has not logged in' do
    include Docs::Api::V1::Users::Index

    before { get '/api/v1/users', headers: default_headers }

    it 'returns 401 status', :dox do
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when user is not admin' do
    include Docs::Api::V1::Users::Index

    it 'returns 403 status', :dox do
      get_users
      expect(response).to have_http_status(:forbidden)
    end
  end

  context 'when user is admin' do
    include Docs::Api::V1::Users::Index

    let(:user) { create(:admin) }

    it 'returns 200 status', :dox do
      get_users
      expect(response).to have_http_status(:ok)
    end

    it 'does not return admins' do
      get '/api/v1/users?sort=role', headers: authenticated_headers(user)
      expect(response_array).not_to include(user)
    end
  end
end
