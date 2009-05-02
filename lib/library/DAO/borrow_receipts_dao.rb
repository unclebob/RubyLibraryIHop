
module Library
  module DAO
    class BorrowReceiptsDAO
      @@borrow_receipts = []

      def self.clear
        @@borrow_receipts = []
      end

      def find_by_patron(patron)
        @@borrow_receipts.find_all {|borrow_receipt| borrow_receipt.patron == patron}
      end

      def save(borrow_receipt)
        @@borrow_receipts << borrow_receipt
      end

      def delete(borrow_receipt)
        @@borrow_receipts.delete(borrow_receipt) 
      end
    end
  end
end