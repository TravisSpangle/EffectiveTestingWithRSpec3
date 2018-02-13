require 'uri'
require 'support/parser_shared_examples'

RSpec.describe URI do
  it_behaves_like 'a URI Parser', URI

  context 'port' do
    it 'defaults http to 80' do
      expect(URI.parse('http://example.com/').port).to eq 80
    end

    it 'defaults https to 443' do
      expect(URI.parse('https://example.com/').port).to eq 443
    end
  end
end
