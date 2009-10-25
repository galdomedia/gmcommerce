require File.dirname(__FILE__) + '/../spec_helper'

describe MenuGroup do
  it "should be valid" do
    MenuGroup.new({:name=>"test2"}).should be_valid
  end
end
