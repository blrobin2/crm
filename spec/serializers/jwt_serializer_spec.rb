RSpec.describe JWTSerializer do
  it "doesn't explode when you pass it nonsense" do
    expect { described_class.decode('nonsense') }.not_to raise_error
  end
end
