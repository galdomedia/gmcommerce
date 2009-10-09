require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    @valid_attributes = {
       :login=>"test",
       :email=>"test@gmcommerceapp.com",
       :password=>"test123",
       :password_confirmation=>"test123"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@valid_attributes)
  end
end
