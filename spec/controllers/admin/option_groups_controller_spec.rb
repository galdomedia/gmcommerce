require File.dirname(__FILE__) + '/../../spec_helper'
 
describe Admin::OptionGroupsController do
  fixtures :all
  integrate_views

  before(:each) do
    activate_authlogic
    UserSession.create(Factory.build(:valid_user))
  end

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Factory.create(:valid_option_group)
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    OptionGroup.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    OptionGroup.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(admin_option_group_url(assigns[:option_group]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Factory.create(:valid_option_group)
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    og = Factory.create(:invalid_option_group)
    OptionGroup.any_instance.stubs(:valid?).returns(false)
    put :update, :id => og
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    OptionGroup.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Factory.create(:valid_option_group)
    response.should redirect_to(admin_option_group_url(assigns[:option_group]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    option_group = Factory.create(:valid_option_group)
    delete :destroy, :id => option_group
    response.should redirect_to(admin_option_groups_url)
    OptionGroup.exists?(option_group.id).should be_false
  end
end
