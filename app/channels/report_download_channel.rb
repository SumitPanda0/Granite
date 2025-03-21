# frozen_string_literal: true

class ReportDownloadChannel < ApplicationCable::Channel
  def subscribed
    if params[:pubsub_token].present?
      stream_from params[:pubsub_token]
    end
  end

  def unsubscribed
    stop_all_streams
  end
end
