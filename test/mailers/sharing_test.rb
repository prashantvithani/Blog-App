require 'test_helper'

class SharingTest < ActionMailer::TestCase
  test "share_blog" do
    mail = Sharing.share_blog
    assert_equal "Share blog", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
