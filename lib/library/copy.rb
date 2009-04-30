module Library
  class Copy
    attr_reader :book, :borrow_receipt
    def initialize(book)
      @book = book
      @borrow_receipt = nil
    end

    def set_borrow_receipt(borrow_receipt)
      @borrow_receipt = borrow_receipt  
    end
  end
end