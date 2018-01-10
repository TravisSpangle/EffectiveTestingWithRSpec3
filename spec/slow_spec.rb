RSpec.configure do |config|
  config.filter_run_excluding slow: true
end

RSpec.describe 'The sleep() method' do
  it ('can sleep for 0.1 second') { sleep 0.1 }
  it ('can sleep for 0.2 second') { sleep 0.2 }
  it ('can sleep for 0.3 second') { sleep 0.3 }
  it 'can sleep for 0.4 second', slow: true do; sleep 0.4; end 
  it 'can sleep for 0.5 second', slow: true do; sleep 0.5; end
end
