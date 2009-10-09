require File.dirname(__FILE__) + '/../spec_helper'

describe Product do

  before(:each) do
    @product = Product.new({:name=>"test", :price=>1})
  end

  it "should be valid" do
    @product.should be_valid
  end

  it "should not be valid" do
    @product.price = "abc"
    @product.should_not be_valid
    @product.name = ""
    @product.should_not be_valid
  end
  
end
