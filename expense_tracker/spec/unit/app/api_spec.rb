require_relative '../../../app/api'
require 'rack/test'
require 'ox'

module ExpenseTracker
  RecordResult = Struct.new(:success?, :expense_id, :error_message)

  RSpec.describe API do
    include Rack::Test::Methods

    def app
      API.new(ledger: ledger)
    end

    def json_response
      JSON.parse(last_response.body)
    end

    def xml_response
      Ox.parse_obj(last_response.body)
    end

    let(:ledger) { instance_double('ExpenseTracker::Ledger') }

    describe 'GET /expenses/:date' do

      let(:date) {'2017-06-12'}

      before do
        allow(ledger).to receive(:expenses_on)
        .with(date)
        .and_return([{'expense_id' => 417}])
      end

      context 'when expenses exist on the given date' do

        it 'returns the expense records as JSON' do
          get "/expenses/#{date}"

          expect(json_response).to include('expense_id' => 417)
        end

        it 'returns the expense records as XML' do
          header 'Accept', 'application/xml;q=0.9'
          get "/expenses/#{date}"

          expect(last_response.headers["Content-Type"]).to include('xml')
          expect(xml_response).to include('expense_id' => 417)
        end

        it 'responds with a 200 (OK)' do
          get "/expenses/#{date}"

          expect(last_response.status).to eq(200)
        end
      end

      context 'when requested format does not exist' do
        it 'returns a 415 `unkown media type` status' do
          header 'Accept', 'application/pirate;q=0.1'
          get "/expenses/#{date}"

          expect(last_response.status).to eq(415)
        end
      end

      context 'when there are no expenses on the given date' do
        it 'returns an empty array as JSON' do
          get "/expenses/#{date}"

          expect(last_response.status).to eq(200)
        end
        it 'responds with a 200 (OK)' do
          get "/expenses/#{date}"

          expect(last_response.status).to eq(200)
        end
      end
    end

    describe 'POST /expenses' do

      let(:expense)  { {'some' => 'data' } }
      before do
        allow(ledger).to receive(:record)
        .with(expense)
        .and_return(RecordResult.new(true, 417, nil))
      end

      context 'when the expense is successfully recorded' do
        it 'returns the expense id as JSON' do
          post '/expenses', JSON.generate(expense)

          expect(json_response).to include('expense_id' => 417)
        end

        it 'returns the expense id as XML' do
          post '/expenses', Ox.dump(expense)

          expect(last_response.headers["Content-Type"]).to include('xml')
          expect(xml_response).to include('expense_id' => 417)
        end

        it 'responds with a 200 (OK)' do
          post '/expenses', JSON.generate(expense)

          expect(last_response.status).to eq(200)
        end
      end

      context 'when the expense fails validation' do
        let(:expense)  { {'some' => 'data' } }

        before do
          allow(ledger).to receive(:record)
          .with(expense)
          .and_return(RecordResult.new(false, 417, 'Expense incomplete'))
        end

        it 'returns an error message' do
          post '/expenses', JSON.generate(expense)

          expect(json_response).to include('error' => 'Expense incomplete')
        end


        it 'responds with a 422 (Unprocessable entity)' do
          post '/expenses', JSON.generate(expense)
          expect(last_response.status).to eq(422)
        end
      end
    end
  end
end
