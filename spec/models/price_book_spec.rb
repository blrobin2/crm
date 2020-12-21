require 'rails_helper'

RSpec.describe PriceBook, type: :model do
  describe 'validations' do
    subject { described_class.new }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to have_many(:price_book_entries) }
    it { is_expected.to have_many(:products) }
  end
end
