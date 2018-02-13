require 'addressable'
require 'support/parser_shared_examples'

RSpec.describe Addressable::URI, 'a parsing library' do
  it_behaves_like 'a URI Parser', Addressable::URI

  it 'parses the scheme' do
    expect(Addressable::URI.parse('https://a.com/').scheme).to eq 'https'
  end

  it 'parses the path' do
    expect(Addressable::URI.parse('http://a.com/foo').path).to eq '/foo'
  end
end
