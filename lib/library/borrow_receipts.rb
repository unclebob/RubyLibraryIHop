module Library
  class BorrowReceipts
    def initialize(patron)
      @patron = patron
      @dao = DAO::BorrowReceiptsDAO.new
    end

    def has_borrow_due_before?(date)
      receipts = @dao.find_by_patron(@patron)
      receipts.any? {|receipt| receipt.due_date < date}
    end

    def add(borrow_receipt)
      @dao.save(borrow_receipt)
    end
    
    def remove(borrow_receipt)
      @dao.delete(borrow_receipt)
    end
  end
end