require File.dirname(__FILE__) + '/../../spec_helper'
 
describe Admin::PagesController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Page.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    Page.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    Page.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(admin_page_url(assigns[:page]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Page.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    Page.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Page.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    Page.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Page.first
    response.should redirect_to(admin_page_url(assigns[:page]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    page = Page.first
    delete :destroy, :id => page
    response.should redirect_to(admin_pages_url)
    Page.exists?(page.id).should be_false
  end
end
