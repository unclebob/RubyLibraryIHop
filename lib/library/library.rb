module Library
  class Library

    def initialize
      @books = {}
    end

    def copy_count(copy)
      count_of(copy.book)
    end

    def checkout(copy, patron)
      count = copy_count(copy) || 0
      @books[copy.book] = count-1
      BorrowReceipt.new(copy, patron, get_now+14)      
    end

    def checkin(copy)
      count = copy_count(copy)
      @books[copy.book] = count+1;
    end

    def get_now
      return Date.now
    end

    def add_copy(copy)
      count = @books[copy.book] || 0
      count += 1
      @books[copy.book] = count
    end

    def count_of(book)
      @books[book]
    end
  end
end