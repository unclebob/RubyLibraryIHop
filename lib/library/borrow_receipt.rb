module Library
  class BorrowReceipt
    attr_reader :copy, :patron, :due_date

    def initialize(copy, patron, due_date)
      @copy = copy
      @patron = patron
      @due_date = due_date
    end
  end
end