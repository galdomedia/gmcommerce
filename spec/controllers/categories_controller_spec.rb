require File.dirname(__FILE__) + '/../spec_helper'

describe CategoriesController do

  #Delete these examples and add some real ones
  it "should use CategoriesController" do
    controller.should be_an_instance_of(CategoriesController)
  end


  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
      
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      c=Factory.create(:valid_category)
      get 'show', :id=>c.to_param
      response.should be_success
    end

    it "should redirect if category is found, but with different param" do
      c = Factory.create(:valid_category)
      get 'show', :id=>c.to_param+"suffix"
      response.should redirect_to(category_url(c))
    end

    it "should redirect, if category does not exists" do
      get 'show', :id=>'something'
      response.should redirect_to(root_url)
    end
  end
end
