require 'test_helper'

class PostMasterTest < ActionMailer::TestCase
  test "your_download_is_ready" do
    @expected.subject = 'PostMaster#your_download_is_ready'
    @expected.body    = read_fixture('your_download_is_ready')
    @expected.date    = Time.now

    assert_equal @expected.encoded, PostMaster.create_your_download_is_ready(@expected.date).encoded
  end

end
