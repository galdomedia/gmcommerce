require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserSessionsController do
  before(:each) do
    activate_authlogic
    @valid_user = Factory.build(:valid_user)
  end
  #Delete this example and add some real ones
  it "should use UserSessionsController" do
    controller.should be_an_instance_of(UserSessionsController)
  end

#  it "should create valid session" do
#    post :create, :user_session => { :login => "tas", :password => "tasiu" }
#    assert user_session = UserSession.find
#    assert_equal @valid_user.login, user_session.user.login
#    assert_redirected_to account_path
#  end

  it "should destroy session" do
    delete :destroy
    assert_nil UserSession.find
    assert_redirected_to new_user_session_path
  end

end
