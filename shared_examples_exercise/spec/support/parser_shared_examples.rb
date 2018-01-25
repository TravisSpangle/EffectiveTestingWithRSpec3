RSpec.shared_examples 'Parser' do |parser|
  it 'parses the host' do
    expect(parser.parse('http://foo.com/').host).to eq 'foo.com'
  end
end
