RSpec.shared_examples 'scope' do
  context 'with no scope defined' do
    let(:params) { ActionController::Parameters.new }

    it 'can throw an error if not scope is passed' do
      expect { instance.filter_scope! }.to raise_error(ActionController::BadRequest)
    end
  end

  context 'with scope defined' do
    let(:params) { ActionController::Parameters.new(filter: { scope: 'admin' }) }
    let(:scope) { { user_role: 'admin' } }

    it 'can fetch the passed scope' do
      allow(instance).to receive(:scope_conditions).and_return({ admin: scope })
      expect(instance.scopes).to match(scope)
    end
  end
end
