require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'validations' do
    subject { described_class.new }

    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
  end

  describe 'email validations' do
    subject { described_class.new(first_name: 'Joe', last_name: 'Briggs', email: 'test@email.com') }

    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end
end
