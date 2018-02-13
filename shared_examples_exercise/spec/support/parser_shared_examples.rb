RSpec.shared_examples 'a URI Parser' do |parser|
  it 'identifies the host' do
    expect(parser.parse('http://foo.com/').host).to eq 'foo.com'
  end

  it 'identifies the port' do
    expect(parser.parse('http://example.com:9876').port).to eq 9876
  end
end
