require 'uri'
require 'support/parser_shared_examples'

RSpec.describe URI do
  it_behaves_like 'Parser', URI

  it 'parses the port' do
    expect(URI.parse('http://example.com:9876').port).to eq 9876
  end

  it 'defaults the port for an http URI to 80' do
    expect(URI.parse('http://example.com/').port).to eq 80
  end

  it 'defaults the port for an https URI to 443' do
    expect(URI.parse('https://example.com/').port).to eq 443
  end
end
