require File.dirname(__FILE__) + '/../spec_helper'

describe Cart do

  before(:each) do
    @product_book = Factory.create(:product_book)
    @product_cd = Factory.create(:product_cd)
    @cart = Cart.new
  end

  it "should be empty on initialization and should be float" do
    @cart.total_price.should == 0.0
  end

  it "should allow adding new products" do
    @cart.add_product(@product_book)
    @cart.add_product(@product_cd)
    @cart.items.size.should == 2
    @cart.total_price.should == 27.75
  end

  it "should only increase products quantity, not number of products" do
    @cart.add_product(@product_book)
    @cart.add_product(@product_book)
    @cart.items.size.should == 1
    @cart.total_price.should == 39.80
  end



end
