require File.dirname(__FILE__) + '/../spec_helper'

describe PropertyTypesController do
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Factory(:valid_property_type)
    response.should render_template(:show)
  end
end
