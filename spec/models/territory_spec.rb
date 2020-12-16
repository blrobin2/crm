require 'rails_helper'

RSpec.describe Territory, type: :model do
  describe 'validations' do
    let(:territory) { described_class.new }
    let(:advisor) { create(:advisor) }
    let(:sales) { create(:sales) }

    it 'validates name' do
      expect(territory).to validate_presence_of(:name)
    end

    it 'validates that assigned advisor is an advisor' do
      territory.advisor = sales
      territory.save

      expect(territory.errors[:advisor]).to be_present
    end

    it 'validates that assigned sales person is sales person' do
      territory.sales = advisor
      territory.save

      expect(territory.errors[:sales]).to be_present
    end
  end
end
