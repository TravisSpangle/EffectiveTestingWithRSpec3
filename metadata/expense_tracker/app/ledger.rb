require_relative '../config/sequel'

module ExpenseTracker
  RecordResult = Struct.new(:success?, :expense_id, :error_message)

  class Ledger
    def record(expense)
      validate_params_present expense
      if @error
        return RecordResult.new(false, nil, @error)
      end

      DB[:expenses].insert(expense)
      id = DB[:expenses].max(:id)
      RecordResult.new(true, id, nil)
    end

    def expenses_on(date)
      DB[:expenses].where(date: date).all
    end

    private

    def validate_params_present(expense)
      %w(payee amount date).each do |param|
        report_error("Invalid expense: `#{param}` is required") unless expense.key? param
      end
    end

    def report_error(msg)
      @error = msg
    end
  end
end
