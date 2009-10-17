require File.dirname(__FILE__) + '/../spec_helper'

describe GiftDiscount do
  it "should be valid" do
    GiftDiscount.new({:name=>"test", :discount_value=>10, :from_cart_value=>12}).should be_valid
  end
end
