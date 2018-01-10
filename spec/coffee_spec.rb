class Coffee
  def ingredients
    @ingredients ||= []
  end

  def add(ingredient)
    ingredients << ingredient
  end

  def price
    1.00 + (ingredients.count * 0.25)
  end

  def inspect
    with = "(with #{ingredients.join(',')})" unless ingredients.nil? 
    "#< Coffee #{with}>"
  end

  def color
    ingredients.include?(:milk) ? :light : :dark
  end

  def temperature
    ingredients.include?(:milk) ? 190.0 : 205.0
  end
end

RSpec.configure do |config| 
  config.example_status_persistence_file_path = 'spec/examples.txt'
  #config.filter_run_when_matching(dollar_store:true)
end

RSpec.describe 'A cup of Coffee' do
  let(:coffee) { Coffee.new }

  it 'costs $1', dollar_store: true  do
    expect(coffee.price).to eq(1.00)
  end

  context 'with milk', focus: true do
    before { coffee.add :milk }

    it 'costs $1.25' do
      expect(coffee.price).to eq(1.25)
    end

    it 'is light in color' do
      skip 'Color not implemented yet'
      expect(coffee.color).to be(:light)
    end

    it 'is cooler than 200 degrees Fahrenheit' do
      pending 'Temperature not implemented yet'
      expect(coffee.temperature).to be < 200.0
    end
  end
end
