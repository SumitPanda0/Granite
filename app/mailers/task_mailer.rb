# frozen_string_literal: true

class TaskMailer < ApplicationMailer
  after_action :create_user_notification, if: -> { !params&.[](:preview) && @receiver }

  def pending_tasks_email(receiver_id)
    @receiver = User.find_by(id: receiver_id)
    return unless @receiver

    @tasks = @receiver.assigned_tasks.pending
    mail(to: @receiver.email, subject: "Pending Tasks")
  end

  private

    def create_user_notification
      @receiver.user_notifications.find_or_create_by(last_notification_sent_date: Time.zone.today)
    end
end
