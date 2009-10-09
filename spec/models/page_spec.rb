require File.dirname(__FILE__) + '/../spec_helper'

describe Page do
  before(:each) do
    @page = Page.new({:title=>"test"})
  end
  it "should be valid" do
    @page.should be_valid
  end

  it "should not be valid" do
    @page.title = nil
    @page.should_not be_valid
    @page.title = ''
    @page.should_not be_valid
  end
end
