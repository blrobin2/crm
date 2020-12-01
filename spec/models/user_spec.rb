require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject(:user) { described_class.new }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_confirmation_of(:password) }

    [:first_name, :last_name].each do |name_field|
      it { is_expected.to allow_value(nil).for(name_field) }
      it { is_expected.to allow_value('Name-Name').for(name_field) }

      it {
        expect(user).not_to allow_value('n@m3')
          .for(name_field)
          .with_message('only allows letters')
      }
    end
  end
end
