class MessageMailer < ActionMailer::Base

  def notification_email(message_id)
    @message = Message.find(message_id)
    @sender = @message.sender
    mail(to: @message.recipient.email, subject: "OS4W: New Message from #{@sender.username}")
  end

end