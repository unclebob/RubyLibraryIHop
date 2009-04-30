module Library
  class BorrowReceipt
    attr_reader :copy, :patron, :due_date

    def initialize(copy, patron, due_date)
      @copy = copy
      @patron = patron
      @due_date = due_date
    end

    def == (br)
      return false if br.nil?
      return false unless br.kind_of? BorrowReceipt
      copy == br.copy && patron == br.patron && due_date == br.due_date
    end
  end
end