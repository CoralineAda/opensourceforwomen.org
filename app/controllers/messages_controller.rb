class MessagesController < ApplicationController

  before_filter :scope_recipient, except: [:index, :show, :destroy]

  def index
    @messages = current_user.incoming_messages
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(
      sender_id: current_user.id,
      recipient_id: message_params[:recipient_id],
      subject: message_params[:subject],
      body: message_params[:body]
    )
    if @message.save
      flash[:success] = 'Message sent successfully.'
      redirect_to pair_profile_path(@message.recipient.pair_profile)
    else
      flash.now[:error] = @message.errors.full_messages
      render 'new'
    end
  end

  def show
    @message = Message.find(params[:id])
  end

  def destroy
    Message.find(params[:id]).destroy
    redirect_to dashboard_path(1)
  end

  private

  def message_params
    params[:message]
  end

  def scope_recipient
    @recipient = User.find(params[:recipient_id] || message_params[:recipient_id])
  end

end