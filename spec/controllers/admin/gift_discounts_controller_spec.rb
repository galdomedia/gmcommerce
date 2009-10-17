require File.dirname(__FILE__) + '/../../spec_helper'
 
describe Admin::GiftDiscountsController do

  before(:each) do
    activate_authlogic
    UserSession.create(Factory.build(:valid_user))
  end
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Factory.create(:valid_gift_discount)
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    GiftDiscount.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    GiftDiscount.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(admin_gift_discount_url(assigns[:gift_discount]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Factory.create(:valid_gift_discount)
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    gd = Factory.create(:invalid_gift_discount)
    GiftDiscount.any_instance.stubs(:valid?).returns(false)
    put :update, :id => gd
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    GiftDiscount.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Factory.create(:valid_gift_discount)
    response.should redirect_to(admin_gift_discount_url(assigns[:gift_discount]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    gift_discount = Factory.create(:valid_gift_discount)
    delete :destroy, :id => gift_discount
    response.should redirect_to(admin_gift_discounts_url)
    GiftDiscount.exists?(gift_discount.id).should be_false
  end
end
