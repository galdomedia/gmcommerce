require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PasswordResetsController do

  #Delete these examples and add some real ones
  it "should use PasswordResetsController" do
    controller.should be_an_instance_of(PasswordResetsController)
  end


  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  
end
