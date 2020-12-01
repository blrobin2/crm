describe 'Login' do
  include Docs::Api::V1::Sessions::Api

  let(:user) { create(:user) }
  let(:session_attributes) do
    {
      type: 'sessions',
      email: user.email,
      password: password
    }
  end
  let(:params) { json_api_params(session_attributes) }
  let(:login) { post '/api/v1/sessions', params: params, headers: default_headers }

  context 'when login is valid' do
    include Docs::Api::V1::Sessions::Create
    let(:password) { '123456' }

    it 'returns 201 status' do
      login
      expect(response).to have_http_status(:created)
    end

    it 'returns the authorization head when login is valid', :dox do
      login
      expect(response.header).to include('authorization')
    end

    it 'returns a JWT containing the jti of the user' do
      login
      token = response.headers['authorization']
      expect(decode_token(token)).to include 'jti'
    end
  end

  context 'when user passes incorrect password' do
    include Docs::Api::V1::Sessions::Create
    let(:password) { 'invalid' }

    it 'returns 422 status' do
      login
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'does not return a JWT token in the header', :dox do
      login
      expect(response.headers['authorization']).to be_nil
    end
  end
end
