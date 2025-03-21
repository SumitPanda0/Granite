# frozen_string_literal: true

class ReportDownloadChannel < ApplicationCable::Channel
  def subscribed
    puts "Channel subscription request with pubsub_token: #{params[:pubsub_token]}"
    puts "Current user: #{current_user.id}"
    stream_from params[:pubsub_token]
  end

  def unsubscribed
    stop_all_streams
  end
end
