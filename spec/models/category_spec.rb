require File.dirname(__FILE__) + '/../spec_helper'

describe Category do
  it "should be valid" do
    Category.new({:name=>"test"}).should be_valid
  end

  it "should not be valid" do
    # this failing test is passing when run via rake spec:models. WTF?
    Category.new().should have(1).errors_on(:name) 
  end

end
