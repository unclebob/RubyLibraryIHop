module Library
  class Library

    def initialize
      @books = {}
    end

    def copy_count(copy)
      count_of(copy.book)
    end

    def checkout(copy, patron)
      raise DelinquentPatron.new if patron.has_borrow_due_before?(get_now)
      
      decrement_copy_count(copy)
      borrow_receipt = BorrowReceipt.new(copy, patron, get_now+14)
      patron.register_borrow(borrow_receipt)
      copy.set_borrow_receipt(borrow_receipt)
      borrow_receipt
    end

    def checkin(copy)
      count = copy_count(copy)
      @books[copy.book] = count+1;
      borrow_receipt = copy.borrow_receipt
      patron = borrow_receipt.patron
      patron.remove(borrow_receipt)
    end

    def get_now
      return Date.now
    end

    def add_copy(copy)
      increment_copy_count(copy)
    end

    def count_of(book)
      @books[book]
    end

    private

    def decrement_copy_count(copy)
      count = copy_count(copy) || 0
      @books[copy.book] = count-1
    end
    
    def increment_copy_count(copy)
      count = @books[copy.book] || 0
      @books[copy.book] = count + 1
    end
  end

 class DelinquentPatron < Exception

 end
end