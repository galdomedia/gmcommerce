require File.dirname(__FILE__) + '/../spec_helper'

describe Option do
  it "should be valid" do
    Option.new({:name=>"test", :code=>"test"}).should be_valid
  end
end
