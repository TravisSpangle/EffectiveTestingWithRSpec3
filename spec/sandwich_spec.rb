Sandwich = Struct.new(:taste, :toppings)

RSpec.describe 'An ideal sandwich' do
  let(:sandwich) { Sandwich.new('delicous', []) }

  it 'is delicious' do
    taste = sandwich.taste
    expect(taste).to eq('delicous')
  end

  it 'lets me add toppings' do
    sandwich.toppings << 'cheese'
    toppings = sandwich.toppings

    expect(toppings).not_to be_empty
  end
end
