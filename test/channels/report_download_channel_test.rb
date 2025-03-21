# frozen_string_literal: true

require "test_helper"

class ReportDownloadChannelTest < ActionCable::Channel::TestCase
  include ActionCable::TestHelper

  def setup
    @user = create(:user)
    @pubsub_token = @user.id

    stub_connection current_user: @user
  end

  def test_subscribed
    subscribe pubsub_token: @pubsub_token
    assert subscription.confirmed?
    assert_has_stream @pubsub_token
    unsubscribe
  end

  def test_does_not_subscribe_without_pubsub_token
    subscribe pubsub_token: nil
    assert_no_streams
  end
end
