require File.dirname(__FILE__) + '/../spec_helper'

describe Comment do
  it "should be valid" do
    Comment.new({:author=>"test", :comment=>"bla bla", :product_id=>Factory(:valid_product).id}).should be_valid
  end
end
