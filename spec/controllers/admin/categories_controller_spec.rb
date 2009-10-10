require File.dirname(__FILE__) + '/../../spec_helper'
 
describe Admin::CategoriesController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Factory.create(:valid_category)
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    Category.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    Category.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(admin_category_url(assigns[:category]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Factory.create(:valid_category)
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    c = Factory.create(:invalid_category)
    Category.any_instance.stubs(:valid?).returns(false)
    put :update, :id => c 
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    Category.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Factory.create(:valid_category)
    response.should redirect_to(admin_category_url(assigns[:category]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    category = Factory.create(:valid_category)
    delete :destroy, :id => category
    response.should redirect_to(admin_categories_url)
    Category.exists?(category.id).should be_false
  end
end
