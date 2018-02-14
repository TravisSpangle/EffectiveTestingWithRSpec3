require 'awesome_print'

RSpec.describe Hash do
# it 'is used by RSpec for metadata', fast: true do |example|
# it 'is used by RSpec for metadata', :fast do |example|
  it 'is used by RSpec for metadata', :fast, :focus do |example|
    ap example.metadata
  end

  context 'on a nested group' do
    it 'is also inherited' do |example|
      ap example.metadata
    end
  end
end
