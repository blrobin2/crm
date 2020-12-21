describe 'AssignUsersToTerritory' do
  include Docs::Api::V1::Territories::Api

  let(:territory) { create(:territory) }
  let(:sales_person) { create(:sales) }
  let(:advisor) { create(:advisor) }
  let(:admin) { create(:admin) }
  let(:params) do
    territory_attributes = {
      type: 'territories',
      sales_id: sales_person.id,
      advisor_id: advisor.id
    }
    json_api_params(territory_attributes)
  end

  context 'when user has not logged in' do
    include Docs::Api::V1::Territories::Update

    before do
      patch "/api/v1/territories/#{territory.id}",
            params: params,
            headers: default_headers
    end

    it 'returns 401 status', :dox do
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when user is not an admin' do
    include Docs::Api::V1::Territories::Update

    context 'when user is not assigned to territory' do
      before do
        patch "/api/v1/territories/#{territory.id}",
              params: params,
              headers: authenticated_headers(sales_person)
      end

      it 'returns 404 status', :dox do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when user is assigned to territory' do
      let(:territory) { create(:territory, sales_id: sales_person.id) }

      before do
        patch "/api/v1/territories/#{territory.id}",
              params: params,
              headers: authenticated_headers(sales_person)
      end

      it 'returns 403 status', :dox do
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  context 'when user is admin' do
    include Docs::Api::V1::Territories::Update

    before do
      patch "/api/v1/territories/#{territory.id}",
            params: params,
            headers: authenticated_headers(admin)
    end

    it 'returns 200 status', :dox do
      expect(response).to have_http_status(:ok)
    end
  end
end
