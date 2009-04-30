require 'rubygems'
require 'spec'
require 'date'
$LOAD_PATH << File.join(File.dirname(__FILE__), "../lib")

require 'library_module.rb'
module Library
  describe BorrowReceipt do
    before do
      @patron = Patron.new("patron")
      @book = Book.new("book")
      @copy = Copy.new(@book)

      @br1 = BorrowReceipt.new(@copy, @patron, Date.new(2009, 4, 30))
      @br2 = BorrowReceipt.new(@copy, @patron, Date.new(2009, 4, 30))
    end

    it "should know if two borrow receipts are equal" do
      @br1.should == @br2
    end

    it "should know if two borrow receipts are not equal" do
      br3 = BorrowReceipt.new( @copy, @patron, Date.new(2009, 4, 29))
      @br1.should_not == br3

      book = Book.new("other book")
      copy = Copy.new(book)

      br4 = BorrowReceipt.new( copy, @patron, Date.new(2009, 4, 30))
      @br1.should_not == br4

      patron = Patron.new("other patron")
      br5 = BorrowReceipt.new( @copy, patron, Date.new(2009, 4, 30))
      @br1.should_not == br5

    end

    it "should not compare nil to be ==" do
      @br1.should_not == nil
    end

    it "should not compare to types that are not borrow receipts" do
      @br1.should_not == @book
    end
  end
end