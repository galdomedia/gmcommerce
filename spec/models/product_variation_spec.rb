require File.dirname(__FILE__) + '/../spec_helper'

describe ProductVariation do
  before(:each) do
    @valid_attributes = {
      :price => 1.5,
      :product_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    ProductVariation.create!(@valid_attributes)
  end
end
