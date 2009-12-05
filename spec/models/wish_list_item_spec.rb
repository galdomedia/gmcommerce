require File.dirname(__FILE__) + '/../spec_helper'

describe WishListItem do
  it "should be valid" do
    WishListItem.new.should be_valid
  end
end
