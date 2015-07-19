class ApplicationMailer < ActionMailer::Base
  default from: ENV['ADMIN_EMAIL']
  layout 'mailer'
end
