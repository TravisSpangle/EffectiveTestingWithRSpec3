require 'addressable'
require 'support/parser_shared_examples'

RSpec.describe Addressable do
  it 'parses the scheme' do
    expect(Addressable::URI.parse('https://a.com/').scheme).to eq 'https'
  end

  it_behaves_like 'Parser', Addressable::URI

  it 'parses the port' do
    expect(Addressable::URI.parse('http://example.com:9876').port).to eq 9876
  end

  it 'parses the path' do
    expect(Addressable::URI.parse('http://a.com/foo').path).to eq '/foo'
  end
end
