require File.dirname(__FILE__) + '/../spec_helper'

describe Producer do
  before(:each) do
    @producer = Factory.build(:valid_producer)
  end
  it "should be valid" do
    @producer.should be_valid
  end

  it "should not be valid" do
    # this failing test is passing when run via rake spec:models. WTF?
    @producer = Factory.build(:invalid_producer)
    @producer.should_not be_valid
  end
end
