require File.dirname(__FILE__) + '/../spec_helper'
 
describe OrdersController do
  
  it "show action should render show template" do
    get :show, :id => Order.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    Order.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    Order.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(order_url(assigns[:order]))
  end
end
