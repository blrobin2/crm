require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { described_class.new }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_confirmation_of(:password) }
    it { is_expected.to have_many(:jti_claims) }
    it { is_expected.to have_many(:sales_territories) }
    it { is_expected.to have_many(:advisor_territories) }
  end

  describe '#territories' do
    let(:territory) { create(:territory_with_assignments) }
    let(:sales_person) { territory.sales_person }
    let(:advisor) { territory.advisor }
    let(:admin) { create(:admin) }

    it 'can fetch territories for a sales person' do
      expect(sales_person.territories).to include(territory)
    end

    it 'can fetch territories for an advisor' do
      expect(advisor.territories).to include(territory)
    end

    it 'can fetch territories for an admin' do
      expect(admin.territories).to be_empty
    end
  end
end
