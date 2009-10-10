require File.dirname(__FILE__) + '/../spec_helper'

describe Category do
  it "should be valid" do
    Factory.build(:valid_category).should be_valid
  end

  it "should not be valid" do
    # this failing test is passing when run via rake spec:models. WTF?
    Factory.build(:invalid_category).should_not be_valid 
  end

end
