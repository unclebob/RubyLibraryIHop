

module Library
  class Patron
    attr_reader :patron_id

    def initialize(patron_id)
      @patron_id = patron_id
      @borrow_receipts = []  
    end

    def register_borrow(borrow_receipt)
      @borrow_receipts << borrow_receipt
    end

    def has_borrow_due_before?(date)
      @borrow_receipts.any? {|receipt| receipt.due_date < date}
    end

    def remove(borrow_receipt)
      @borrow_receipts.delete(borrow_receipt)
    end

    def == (other)
      return false if other.nil?
      return false unless other.kind_of? Patron
       patron_id == other.patron_id
    end
  end
end