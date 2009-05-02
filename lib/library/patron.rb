

module Library
  class Patron
    attr_reader :card_number

    def initialize(card_number)
      @card_number = card_number
      @borrow_receipts = BorrowReceipts.new(self)
    end

    def register_borrow(borrow_receipt)
      @borrow_receipts.add borrow_receipt
    end

    def has_borrow_due_before?(date)
      @borrow_receipts.has_borrow_due_before? date
    end

    def remove(borrow_receipt)
      @borrow_receipts.remove(borrow_receipt)
    end

    def == (other)
      return false if other.nil?
      return false unless other.kind_of? Patron
       card_number == other.card_number
    end
  end
end