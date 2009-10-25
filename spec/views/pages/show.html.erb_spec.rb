require 'spec_helper'

describe "/pages/show" do
  before(:each) do
    @page = Factory.create(:valid_page)
    render 'pages/show'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
    response.should have_tag('h1', %r[#{@page.title}])
  end
end
