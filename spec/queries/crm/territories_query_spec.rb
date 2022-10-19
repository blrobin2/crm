require 'rails_helper'

RSpec.describe Crm::TerritoriesQuery do
  let(:sales_person) { create(:sales, :with_territories) }
  let(:advisor) { create(:advisor, :with_territories) }
  let(:admin) { create(:admin) }
  let(:params) { ActionController::Parameters.new }

  context 'when current user is sales person' do
    let(:territories_query) { described_class.new(sales_person, params) }

    it 'only fetches their territories' do
      territories = territories_query.all
      sales_territories = sales_person.territories.pluck(&:id).sort
      expect(territories.pluck(&:id).sort).to match(sales_territories)
    end
  end

  context 'when current user is advisor' do
    let(:territories_query) { described_class.new(advisor, params) }

    it 'only fetches their territories' do
      territories = territories_query.all
      advisor_territories = advisor.territories.pluck(&:id).sort
      expect(territories.pluck(&:id).sort).to match(advisor_territories)
    end
  end

  context 'when current user is admin' do
    let(:territories_query) { described_class.new(admin, params) }

    it 'fetches all territories' do
      territories = territories_query.all
      sales_territories = sales_person.territories.pluck(&:id)
      advisor_territories = advisor.territories.pluck(&:id)
      admin_territories = (advisor_territories + sales_territories).sort
      expect(territories.pluck(&:id).sort).to match(admin_territories)
    end
  end

  context 'when top_level filter is passed' do
    let(:params) { ActionController::Parameters.new(filter: { top_level: true }) }
    let(:territories_query) { described_class.new(admin, params) }

    it 'fetches territories without a parent_id' do
      territories = territories_query.all
      expect(territories.pluck(&:parent_id).compact).to be_empty
    end
  end
end
