require File.dirname(__FILE__) + '/../spec_helper'

describe OptionGroup do
  it "should be valid" do
    OptionGroup.new({:name=>"test"}).should be_valid
  end
end
