require 'sinatra/base'
require 'json'
require_relative 'ledger'
require 'ox'

module ExpenseTracker
  class API < Sinatra::Base

    def initialize(ledger: Ledger.new)
      @ledger = ledger
      super()
    end

    def type
      @type ||= ['application/json', 'application/xml'].find(->{"unkown"}) { |type| request.accept?(type) }.split('/').last
    end

    post '/expenses' do
      expense = send("#{type}_parse", request.body.read)
      return send("#{type}_response") if expense.nil?

      result = @ledger.record(expense)

      if result.success?
        send("#{type}_response", {body: {'expense_id' => result.expense_id}})
      else
        status 422
        send("#{type}_response", {body: {'error' => result.error_message}})
      end
    end

    get '/expenses/:date' do
      expenses = @ledger.expenses_on(params[:date])

      send("#{type}_response", {body: expenses})
    end

    private

    def json_response(body:)
      JSON.generate(body)
    end

    def xml_response(body:)
      response.headers["Content-Type"] = 'application/xml'
      Ox.dump(body)
    end

    def unkown_response(body:nil)
      status 415
    end

    def json_parse(body)
      JSON.parse(body)
    end

    def xml_parse(body)
      Ox.parse_obj(body)
    end

    def unkown_parse(body)
      nil
    end
  end
end
