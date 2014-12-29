require 'test_helper'

class NotificationsMailerTest < ActionMailer::TestCase
  test "notifications" do
    mail = NotificationsMailer.notifications
    assert_equal "Notifications", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
