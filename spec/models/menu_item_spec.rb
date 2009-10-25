require File.dirname(__FILE__) + '/../spec_helper'

describe MenuItem do
  it "should be valid" do
    MenuItem.new({:menu_group_id=>Factory(:valid_menu_group).id, :name=>"test", :url=>"inner"}).should be_valid
  end
end
