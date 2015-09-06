class InvitationMailer < ApplicationMailer

  def invitation_email(invitation_id)
    @invitation = Invitation.find(invitation_id)
    @sender = @invitation.user
    mail(to: @invitation.invitee_email, subject: "Your Invitation to join OS4W!")
  end

end