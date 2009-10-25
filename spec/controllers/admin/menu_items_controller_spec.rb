require File.dirname(__FILE__) + '/../../spec_helper'
 
describe Admin::MenuItemsController do
  
  before(:each) do
    activate_authlogic
    UserSession.create(Factory.build(:valid_user))
    @menu_group = Factory.create(:valid_menu_group)
  end
  
  it "index action should render index template" do
    get :index, :menu_group_id=>@menu_group.id
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Factory.create(:valid_menu_item), :menu_group_id=>@menu_group.id
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new, :menu_group_id=>@menu_group.id
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    MenuItem.any_instance.stubs(:valid?).returns(false)
    post :create, :menu_group_id=>@menu_group.id
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    MenuItem.any_instance.stubs(:valid?).returns(true)
    post :create, :menu_group_id=>@menu_group.id
    response.should redirect_to(admin_menu_group_menu_item_url(@menu_group, assigns[:menu_item]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Factory.create(:valid_menu_item), :menu_group_id=>@menu_group.id
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    mi = Factory.create(:invalid_menu_item)
    MenuItem.any_instance.stubs(:valid?).returns(false)
    put :update, :id => mi, :menu_group_id=>@menu_group.id
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    MenuItem.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Factory.create(:valid_menu_item), :menu_group_id=>@menu_group.id
    response.should redirect_to(admin_menu_group_menu_item_url(@menu_group,assigns[:menu_item]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    menu_item = Factory.create(:valid_menu_item)
    delete :destroy, :id => menu_item, :menu_group_id=>@menu_group.id
    response.should redirect_to(admin_menu_group_menu_items_url(@menu_group))
    MenuItem.exists?(menu_item.id).should be_false
  end
end
