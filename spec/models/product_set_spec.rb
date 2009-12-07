require File.dirname(__FILE__) + '/../spec_helper'

describe ProductSet do
  it "should be valid" do
    ProductSet.new.should be_valid
  end
end
