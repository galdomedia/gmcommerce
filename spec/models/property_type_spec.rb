require File.dirname(__FILE__) + '/../spec_helper'

describe PropertyType do
  before(:each) do
    @property = Factory.build(:valid_property_type)
  end
  it "should be valid" do
    @property.should be_valid
  end
  it "should not be valid" do
    @property = Factory.build(:valid_property_type)
    @property.field_type = 123
    @property.should_not be_valid
    @property = Factory.build(:valid_property_type)
    @property.name = ""
    @property.should_not be_valid
    @property = Factory.build(:valid_property_type)
  end

  it "should not allow duplicated identifiers" do
    Factory.create(:valid_property_type)
    @property = Factory.build(:valid_property_type)
    @property.should_not be_valid
  end
end
