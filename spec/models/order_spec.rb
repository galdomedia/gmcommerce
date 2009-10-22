require File.dirname(__FILE__) + '/../spec_helper'

describe Order do
  it "should be valid" do
    Order.new({:contacts_attributes=>[{:is_shipping=>true, :is_billing=>true, :last_name=>"test", :first_name=>"test", :email=>"a@b.com", :phone=>"21134"}]}).should be_valid
  end
end
