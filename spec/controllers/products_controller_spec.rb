require File.dirname(__FILE__) + '/../spec_helper'

describe ProductsController do

  #Delete these examples and add some real ones
  it "should use ProductsController" do
    controller.should be_an_instance_of(ProductsController)
  end


  describe "GET 'show'" do
    it "should be successful" do
      get 'show', :id=>Factory.create(:valid_product).to_param
      response.should be_success
    end
    it "should redirect if product is found, but with different param" do
      p = Factory.create(:valid_product)
      get 'show', :id=>p.to_param+"suffix"
      response.should redirect_to(product_url(p))
    end

    it "should redirect, if product does not exists" do
      get 'show', :id=>'something'
      response.should redirect_to(root_url)
    end
  end
end
