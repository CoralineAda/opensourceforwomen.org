class PairRequestsController < ApplicationController

  before_filter :scope_recipient, except: [:show]

  def new
    @pair_request = PairRequest.new
  end

  def create
    pair_request = PairRequest.create(
      sender_id: current_user.id,
      recipient_id: pair_request_params[:recipient_id],
      message: pair_request_params[:message]
    )
    redirect_to pair_profile_path(pair_request.recipient.pair_profile)
  end

  def show
    pair_request = PairRequest.find(params[:id])
  end

  def scope_recipient
    @recipient = User.find(params[:recipient_id] || pair_request_params[:recipient_id])
  end

  private

  def pair_request_params
    params[:pair_request]
  end

end