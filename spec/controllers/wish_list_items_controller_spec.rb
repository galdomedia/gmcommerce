require File.dirname(__FILE__) + '/../spec_helper'
 
describe WishListItemsController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    WishListItem.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    WishListItem.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(wish_list_items_url)
  end
  
  it "destroy action should destroy model and redirect to index action" do
    wish_list_item = WishListItem.first
    delete :destroy, :id => wish_list_item
    response.should redirect_to(wish_list_items_url)
    WishListItem.exists?(wish_list_item.id).should be_false
  end
end
