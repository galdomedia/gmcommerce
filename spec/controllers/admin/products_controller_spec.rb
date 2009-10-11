require File.dirname(__FILE__) + '/../../spec_helper'
 
describe Admin::ProductsController do

  before(:each) do
    activate_authlogic
    UserSession.create(Factory.build(:valid_user))
  end
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Factory.create(:valid_product)
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    Product.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    Product.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(admin_product_url(assigns[:product]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Factory.create(:valid_product)
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    p = Factory.create(:invalid_product)
    Product.any_instance.stubs(:valid?).returns(false)
    put :update, :id => p
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    Product.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Factory.create(:valid_product)
    response.should redirect_to(admin_product_url(assigns[:product]))
  end

  it "should allow saving habtm categories" do
    p = Factory.create(:valid_product)
    put :update, :id => p, :product=>{:category_ids=>[Factory.create(:valid_category).id]}
    p.categories.should have(1).records  
  end
  
  it "destroy action should destroy model and redirect to index action" do
    product = Factory.create(:valid_product)
    delete :destroy, :id => product
    response.should redirect_to(admin_products_url)
    Product.exists?(product.id).should be_false
  end
end
