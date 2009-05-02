require 'rubygems'
require 'spec'
require 'date'
$LOAD_PATH << File.join(File.dirname(__FILE__), "../lib")

require 'library_module.rb'
module Library
  describe Library do
    before do
      DAO::BorrowReceiptsDAO.clear
      @library = TestLibrary.new
      @today = @library.get_now
      @patron_card_number = "314159"
      @patron = Patron.new(@patron_card_number)
      @library.add_patron(@patron)
      @book = Book.new("War and Peace")
      @copy = Copy.new(@book)
      @library.add_copy(@copy)
    end

    it "should know how many copies of a book there are" do
      @library.count_of(@book).should == 1
    end

    it "should know how many copies of other books there are" do
      ppp = Book.new("PPP")
      @library.add_copy(Copy.new(ppp))
      @library.add_copy(Copy.new(ppp))
      @library.count_of(ppp).should == 2
    end

    it "should produce a borrow receipt when a patron checks out a book" do
      borrow_receipt = @library.checkout(@copy, @patron)
      borrow_receipt.copy.should be(@copy)
      borrow_receipt.patron.should be(@patron)
      borrow_receipt.due_date.should == (@today+14)
    end

    it "should decrement copy count when patron checks out book" do
      borrow_receipt = @library.checkout(@copy, @patron)
      @library.count_of(@book).should == 0
    end

    it "should increment copy count when patron checks in book" do
      @library.checkout(@copy, @patron)
      @library.checkin(@copy)
      @library.count_of(@book).should == 1
    end

    it "should not allow patron to check out book if he has other books that are delinquent" do
      ppp = Book.new("PPP")
      ppp_copy = Copy.new(ppp)
      @library.add_copy( ppp_copy)

      borrow_date = Date.new(2009, 4, 30)
      delinquent_date = borrow_date + 20

      @library.set_now(borrow_date)
      @library.checkout(@copy, @patron)
      @library.set_now(delinquent_date)
      proc {@library.checkout(ppp_copy, @patron)}.should raise_error(DelinquentPatron)
    end

    it "should clear delinquency when delinquent book is checked in" do
      borrow_date = Date.new(2009, 4, 30)
      delinquent_date = borrow_date + 20

      @library.set_now(borrow_date)
      @library.checkout(@copy, @patron)

      @library.set_now(delinquent_date)
      @library.checkin(@copy)
      @patron.has_borrow_due_before?(delinquent_date).should be(false)
    end

    it "should should recognize a patron from the code on his library card" do
      patron = @library.get_patron(@patron_card_number)
      patron.should be(@patron)
    end



  end

  class TestLibrary < Library
    def initialize
      super
      @now = Date.new(2009, 4, 30)
    end

    def set_now(date)
      @now = date
    end

    def get_now
      @now
    end
  end
end

#  @patron checks_out @copy from @inventory