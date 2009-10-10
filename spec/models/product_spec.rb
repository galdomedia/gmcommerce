require File.dirname(__FILE__) + '/../spec_helper'

describe Product do

  before(:each) do
    @product = Factory.build(:valid_product)
  end

  it "should be valid" do
    @product.should be_valid
  end

  it "should not be valid" do
    # this failing test is passing when run via rake spec:models. rspec fails to test model with validates_presence_of :name
    @product = Factory.build(:invalid_product)
    @product.should_not be_valid
    @product = Factory.build(:product_with_wrong_price)
    @product.should_not be_valid
  end


  
end
