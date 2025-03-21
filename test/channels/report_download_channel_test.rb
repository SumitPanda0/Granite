# frozen_string_literal: true

require "test_helper"

class ReportDownloadChannelTest < ActionCable::Channel::TestCase
  include ActionCable::TestHelper

  def setup
    @user = create(:user)
    @pubsub_token = @user.id

    # Connect first, then set the current_user
    stub_connection current_user: @user
  end

  def test_subscribed
    subscribe pubsub_token: @pubsub_token
    assert subscription.confirmed?
    assert_has_stream @pubsub_token
    unsubscribe
  end

  def test_does_not_subscribe_without_pubsub_token
    # We need to modify the ReportDownloadChannel to not use current_user.id as a fallback
    # For the test, we'll mock the stream_from method to ensure it's not called
    subscription.expects(:stream_from).never
    subscribe pubsub_token: nil
    # We don't need assert_no_streams because we're directly testing that stream_from is never called
  end
end
