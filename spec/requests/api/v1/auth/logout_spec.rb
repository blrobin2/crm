describe 'Logout' do
  include Docs::Api::V1::Sessions::Api
  let(:user) { create(:user) }

  context 'when existing user has logged in' do
    include Docs::Api::V1::Sessions::Delete

    let(:logout_user) { delete '/api/v1/sessions', headers: authenticated_headers(user) }

    it 'returns 204 status' do
      logout_user
      expect(response).to have_http_status(:no_content)
    end

    it 'changes users jti_claims after logout', :dox do
      expect { logout_user }.to(change { user.reload.jti_claims.size })
    end
  end

  context 'when user has not logged in' do
    include Docs::Api::V1::Sessions::Delete

    before { delete '/api/v1/sessions', headers: default_headers }

    it 'returns 401 status', :dox do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
