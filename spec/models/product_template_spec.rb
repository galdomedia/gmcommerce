require File.dirname(__FILE__) + '/../spec_helper'

describe ProductTemplate do
  it "should be valid" do
    ProductTemplate.new({:template_name=>"test"}).should be_valid
  end
end
