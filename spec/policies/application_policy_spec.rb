require 'rails_helper'

RSpec.describe ApplicationPolicy do
  subject { described_class.new(user, user) }

  describe 'it should not permit anyone by default' do
    let(:user) { create(:user) }

    it { is_expected.not_to permit(:index) }
    it { is_expected.not_to permit(:create) }
    it { is_expected.not_to permit(:new) }
    it { is_expected.not_to permit(:show) }
    it { is_expected.not_to permit(:update) }
    it { is_expected.not_to permit(:edit) }
    it { is_expected.not_to permit(:destroy) }
  end
end
