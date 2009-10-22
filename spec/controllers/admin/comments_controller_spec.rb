require File.dirname(__FILE__) + '/../../spec_helper'
 
describe Admin::CommentsController do
  
  before(:each) do
    activate_authlogic
    UserSession.create(Factory.build(:valid_user))
    @product = Factory.create(:valid_product)
  end
  
  it "index action should render index template" do
    get :index, :product_id=>@product.id
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Factory.create(:valid_comment), :product_id=>@product.id
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new, :product_id=>@product.id
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    Comment.any_instance.stubs(:valid?).returns(false)
    post :create, :product_id=>@product.id
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    Comment.any_instance.stubs(:valid?).returns(true)
    post :create, :product_id=>@product.id
    response.should redirect_to(admin_product_comment_url(@product, assigns[:comment]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Factory.create(:valid_comment), :product_id=>@product.id
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    c = Factory(:invalid_comment)
    Comment.any_instance.stubs(:valid?).returns(false)
    put :update, :id => c, :product_id=>@product.id
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    Comment.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Factory(:valid_comment), :product_id=>@product.id
    response.should redirect_to(admin_product_comment_url(@product, assigns[:comment]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    comment = Factory(:valid_comment)
    delete :destroy, :id => comment, :product_id=>@product.id
    response.should redirect_to(admin_product_comments_url(@product))
    Comment.exists?(comment.id).should be_false
  end
end
