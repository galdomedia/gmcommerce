require File.dirname(__FILE__) + '/../spec_helper'

describe Shipment do
  it "should be valid" do
    Shipment.new({:name=>"test", :cost=>10.5}).should be_valid
  end
end
