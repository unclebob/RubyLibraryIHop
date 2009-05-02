module Library
  class Patrons

    def initialize
      @patrons = {}
    end

    def add(patron)
      @patrons[patron.card_number] = patron
    end

    def [](card_number)
      @patrons[card_number] 
    end

  end
end