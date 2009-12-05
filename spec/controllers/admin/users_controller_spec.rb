require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::UsersController do

  before(:each) do
    activate_authlogic
    UserSession.create(Factory.build(:valid_user))
  end
  
  #Delete these examples and add some real ones
  it "should use Admin::UsersController" do
    controller.should be_an_instance_of(Admin::UsersController)
  end


  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

end
