require File.dirname(__FILE__) + '/../../spec_helper'
 
describe Admin::ProductTemplatesController do

  before(:each) do
    activate_authlogic
    UserSession.create(Factory.build(:valid_user))
  end
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Factory.create(:valid_product_template)
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    ProductTemplate.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    ProductTemplate.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(admin_product_template_url(assigns[:product_template]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Factory.create(:valid_product_template)
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    pt = Factory.create(:invalid_product_template)
    ProductTemplate.any_instance.stubs(:valid?).returns(false)
    put :update, :id => pt
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    ProductTemplate.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Factory.create(:valid_product_template)
    response.should redirect_to(admin_product_template_url(assigns[:product_template]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    product_template = Factory.create(:valid_product_template)
    delete :destroy, :id => product_template
    response.should redirect_to(admin_product_templates_url)
    ProductTemplate.exists?(product_template.id).should be_false
  end
end
