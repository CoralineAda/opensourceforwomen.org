class InvitationsController < ApplicationController

  def new
    @invitation = Invitation.new(user: current_user)
  end

  def create
    @invitation = Invitation.new(invitation_params)
    @invitation.user = current_user
    if @invitation.save
      InvitationMailer.invitation_email(@invitation.id.to_s).deliver_later
      flash.notice = 'Thank you for sending an invation!'
      redirect_to dashboard_path(1)
    else
      flash.now[:error] = 'Sorry! We were unable to send your invitation.'
      render :new
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:invitee_email, :message)
  end

end