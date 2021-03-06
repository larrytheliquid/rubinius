require File.dirname(__FILE__) + '/../../spec_helper'
require File.dirname(__FILE__) + '/fixtures/classes'

describe "Numeric#floor" do
  before(:each) do
    @obj = NumericSub.new
  end
  
  it "converts self to a Float (using #to_f) and returns the #floor'ed result" do
    @obj.should_receive(:to_f).and_return(2 - TOLERANCE, TOLERANCE - 2)
    @obj.floor.should == 1
    @obj.floor.should == -2
  end
end