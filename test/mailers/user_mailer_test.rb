require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "mailer_created" do
    mail = UserMailer.mailer_created
    assert_equal "Mailer created", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
