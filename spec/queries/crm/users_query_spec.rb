require 'rails_helper'

RSpec.describe Crm::UsersQuery do
  let(:users) { create_list(:user, 100) }
  let(:current_user) { users.first }
  let(:params) { ActionController::Parameters.new }
  let(:users_query) { described_class.new(current_user, params) }

  describe 'associations' do
    let(:params) { ActionController::Parameters.new(include: 'jti_claims') }

    it 'can fetch associated jti claims' do
      user = users_query.all.first
      expect(user.jti_claims.to_a).not_to be_empty
    end
  end

  describe 'query parameters' do
    context 'with no params' do
      it 'returns the first 25 users' do
        all_users = users_query.all.to_a
        expect(all_users.size).to equal(Kaminari.config.default_per_page)
      end
    end

    context 'with page size params' do
      let(:page_size) { 49 }
      let(:params) { ActionController::Parameters.new(page: { size: page_size }) }

      it 'returns the first 49 users' do
        all_users = users_query.all.to_a
        expect(all_users.size).to equal(page_size)
      end
    end

    context 'with page size that exceeds max' do
      let(:page_size) { Kaminari.config.max_per_page + 100 }
      let(:params) { ActionController::Parameters.new(page: { size: page_size }) }

      it 'returns the max users' do
        all_users = users_query.all.to_a
        expect(all_users.size).to equal(Kaminari.config.max_per_page)
      end
    end

    context 'with user id in parameters' do
      let(:params) { ActionController::Parameters.new(id: current_user.id) }

      it 'finds the current user by id in parameters' do
        user = users_query.find
        expect(user).to eq(current_user)
      end

      it 'finds the current user by passing id' do
        user = users_query.find(current_user.id)
        expect(user).to eq(current_user)
      end

      it 'finds the current user by passing first_name' do
        user = users_query.find(current_user.first_name, by: :first_name)
        expect(user.first_name).to eq(current_user.first_name)
      end
    end
  end
end
