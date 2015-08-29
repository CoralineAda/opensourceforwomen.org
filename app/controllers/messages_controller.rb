class MessagesController < ApplicationController

  before_filter :scope_recipient, except: [:index, :show, :destroy]

  # FIXME showing up empty
  def index
    @conversations = current_user.conversations
  end

  def new
    in_reply_to = params[:message_id] && Message.find(params[:message_id])
    @conversation = in_reply_to ? in_reply_to.conversation : Conversation.new
    @recipient = @conversation.other_participant(current_user) || User.new
    @message = Message.new(
      conversation: @conversation,
      recipient: @recipient
    )
  end

  def create
    @message = Message.new(
      sender_id: current_user.id,
      recipient_id: message_params[:recipient_id],
      body: message_params[:body],
      conversation_id: message_params[:conversation_id]
    )

    unless @message.conversation
      conversation = Conversation.new
      conversation.participants = [current_user, @message.recipient]
      conversation.save
      @message.conversation = conversation
    end

    if @message.save
      flash[:success] = 'Message sent successfully.'
      redirect_to messages_path
    else
      flash.now[:error] = @message.errors.full_messages
      render 'new'
    end
  end

  def show
    @message = Message.find(params[:id])
    @message.update_attribute(:is_read, true)
    @conversation = @message.conversation
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
    @recipient = params[:recipient_id] ? User.find(params[:recipient_id]) : User.new
  end

end