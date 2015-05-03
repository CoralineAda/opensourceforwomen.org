class UserMailer < ApplicationMailer

  def activation_needed_email(user)
    @user = user
    mail(to: user.email, subject: "Account activation")
  end

  def activation_success_email(user)
    @user = user
    mail(to: user.email, subject: "Your account is now activated")
  end

end