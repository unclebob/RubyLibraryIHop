require 'rubygems'
require 'spec'
require 'date'
$LOAD_PATH << File.join(File.dirname(__FILE__), "../lib")

require 'library_module.rb'
module Library


  describe Patron do

    before do
      @p1 = Patron.new("bob")

    end

    it "should know if two Patrons are equal" do
       p2 = Patron.new("bob")
      @p1.should == p2
    end

    it "should know if two Patrons are not equal" do
      @p1 = Patron.new("bob")
      p2 = Patron.new("the anti-bob")
      @p1.should_not == p2
    end

    it "should handle nil " do
      @p1.should_not == nil
    end

    it "should handle unlike types" do
      @p1.should_not == Book.new("some book")
    end
  end
end
