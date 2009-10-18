require File.dirname(__FILE__) + '/../spec_helper'

describe Contact do
  it "should be valid" do
    Contact.new({:first_name=>"test", :last_name=>"test2", :street=>"test", :street_nr=>"2/3", :city=>"test", :zip_code=>"65464", :country=>"test"}).should be_valid
  end
end
