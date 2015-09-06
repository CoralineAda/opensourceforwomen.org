class MessageWorker

  include Sidekiq::Worker

  def perform(message_id)
    message = Message.find(message_id)
    recipient = message.recipient
    return if message.is_seen
    MessageMailer.notification_email(message.id).deliver
  end

end