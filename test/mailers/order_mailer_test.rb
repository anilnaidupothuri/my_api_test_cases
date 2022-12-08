require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase
  setup do 
    @order = orders(:one)
  end
  test "send_confirmation" do
    mail = OrderMailer.send_confirmation(@order)
    assert_equal "Order Confirmation", mail.subject
    assert_equal [@order.user.email], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
