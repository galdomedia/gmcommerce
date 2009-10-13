require File.dirname(__FILE__) + '/../../spec_helper'
 
describe Admin::ShipmentsController do

  before(:each) do
    activate_authlogic
    UserSession.create(Factory.build(:valid_user))
  end
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Factory.create(:valid_shipment)
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    Shipment.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    Shipment.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(admin_shipment_url(assigns[:shipment]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Factory.create(:valid_shipment)
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    s = Factory.create(:valid_shipment)
    Shipment.any_instance.stubs(:valid?).returns(false)
    put :update, :id => s
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    Shipment.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Factory.create(:valid_shipment)
    response.should redirect_to(admin_shipment_url(assigns[:shipment]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    shipment = Factory.create(:valid_shipment)
    delete :destroy, :id => shipment
    response.should redirect_to(admin_shipments_url)
    Shipment.exists?(shipment.id).should be_false
  end
end
