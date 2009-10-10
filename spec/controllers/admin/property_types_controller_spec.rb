require File.dirname(__FILE__) + '/../../spec_helper'
 
describe Admin::PropertyTypesController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Factory.create(:valid_property_type)
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    PropertyType.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    PropertyType.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(admin_property_type_url(assigns[:property_type]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Factory.create(:valid_property_type)
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    p = Factory.create(:invalid_property_type)
    PropertyType.any_instance.stubs(:valid?).returns(false)
    put :update, :id => p
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    PropertyType.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Factory.create(:valid_property_type)
    response.should redirect_to(admin_property_type_url(assigns[:property_type]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    property_type = Factory.create(:valid_property_type)
    delete :destroy, :id => property_type
    response.should redirect_to(admin_property_types_url)
    PropertyType.exists?(property_type.id).should be_false
  end
end
