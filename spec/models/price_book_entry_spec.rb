require 'rails_helper'

RSpec.describe PriceBookEntry, type: :model do
  describe 'validations' do
    subject { described_class.new }

    it { is_expected.to validate_presence_of(:list_price) }
    it { is_expected.to validate_numericality_of(:list_price).is_greater_than(0) }
    it { is_expected.to belong_to(:product) }
    it { is_expected.to belong_to(:price_book) }
  end
end
