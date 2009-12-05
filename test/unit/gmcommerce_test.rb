require 'test_helper'

class GmcommerceTest < ActionMailer::TestCase
  test "contact_request" do
    @expected.subject = 'Gmcommerce#contact_request'
    @expected.body    = read_fixture('contact_request')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Gmcommerce.create_contact_request(@expected.date).encoded
  end

  test "recommend" do
    @expected.subject = 'Gmcommerce#recommend'
    @expected.body    = read_fixture('recommend')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Gmcommerce.create_recommend(@expected.date).encoded
  end

end
