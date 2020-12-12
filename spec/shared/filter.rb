RSpec.shared_examples 'filter' do
  let(:params) { ActionController::Parameters.new(filter: { 'all_the_joes': true }) }

  it 'parses the keys to be filtered from params' do
    allow(instance).to receive(:filter_conditions).and_return(all_the_joes: { 'first_name': 'Joe' })
    expect(instance.filters).to match([{ first_name: 'Joe' }])
  end

  it 'can define default where conditions for the query' do
    allow(instance).to receive(:where_conditions).and_return({ last_name: 'Cool' })
    expect(instance.all_without_pagination.to_sql).to include("\"last_name\" = 'Cool'")
  end
end
