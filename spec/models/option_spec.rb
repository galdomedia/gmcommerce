require File.dirname(__FILE__) + '/../spec_helper'

describe Option do
  it "should be valid" do
    Option.new.should be_valid
  end
end
