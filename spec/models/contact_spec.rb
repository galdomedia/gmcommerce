require File.dirname(__FILE__) + '/../spec_helper'

describe Contact do
  it "should be valid" do
    Contact.new({:first_name=>"test", :last_name=>"test2", :street=>"test", :street_nr=>"2/3", :city=>"test", :zip_code=>"65464", :country=>"test", :is_billing=>true, :email=>"a@b.com", :phone=>"213124"}).should be_valid
  end
  
  it "should be valid if it is company" do
    Contact.new({:first_name=>"test", :last_name=>"test2", :street=>"test", :street_nr=>"2/3", :city=>"test", :zip_code=>"65464", :country=>"test", :is_shipping=>true, :is_company=>true, :company_name=>"test"}).should be_valid
  end
end
