require File.dirname(__FILE__) + '/../../spec_helper'
 
describe Admin::OrdersController do

  before(:each) do
    activate_authlogic
    UserSession.create(Factory.build(:valid_user))
    Order.any_instance.stubs(:set_initial_state)    
  end
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Factory(:valid_order, :status=>"temporary")
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
    response.should redirect_to(admin_order_url(assigns[:order]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Factory(:valid_order, :status=>"temporary")
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    o = Factory(:invalid_order, :status=>"temporary")
    Order.any_instance.stubs(:valid?).returns(false)
    put :update, :id => o
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    Order.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Factory.create(:valid_order, :status=>"temporary")
    response.should redirect_to(admin_order_url(assigns[:order]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    order = Factory(:valid_order, :status=>"temporary")
    delete :destroy, :id => order
    response.should redirect_to(admin_orders_url)
    Order.exists?(order.id).should be_false
  end
end
