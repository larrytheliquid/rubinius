require File.dirname(__FILE__) + '/../../spec_helper'
require File.dirname(__FILE__) + '/fixtures/classes'
require 'enumerator'

describe "Enumerator#enum_cons" do
  ruby_version_is ''...'1.9' do
    it "returns an enumerator of the receiver with iteration of each_cons for each array of n concecutive elements" do
      a = []
      enum = EnumSpecs::Numerous.new.enum_cons(3)
      enum.each {|x| a << x}
      enum.should be_kind_of(enumerator_class)
      a.should == [[2, 5, 3], [5, 3, 6], [3, 6, 1], [6, 1, 4]]
    end  
  end
end