# frozen_string_literal: true

class TaskLoggerJob
  include Sidekiq::Job

  def perform(task_id)
    Sidekiq.logger.info("Starting TaskLoggerJob for task_id: #{task_id}")
    task = Task.find(task_id)
    message = LoggerMessageBuilderService.new(task).process!

    log = Log.create!(task_id: task.id, message:)
    Sidekiq.logger.info(log.message)
  end
end
