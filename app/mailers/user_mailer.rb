class UserMailer < ApplicationMailer

  def activation_needed_email(user)
    @user = user
    mail(to: user.email, subject: "OS4W: Account activation")
  end

  def activation_success_email(user)
    @user = user
    mail(to: user.email, subject: "OS4W: Your account is now activated")
  end

  def reset_password_email(user)
    @user = user
    mail(:to => user.email, :subject => "OS4W: Password Reset Instructions")
  end

end