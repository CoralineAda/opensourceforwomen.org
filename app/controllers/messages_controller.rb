class MessagesController < ApplicationController

  before_filter :scope_recipient, except: [:index, :show, :destroy]

  # FIXME showing up empty
  def index
    @conversations = current_user.conversations
  end

  def new
    conversation = params[:conversation_id] ? Conversation.find(params[:conversation_id]) : Conversation.new
    @message = Message.new(
      conversation: conversation,
      recipient: conversation.other_participant(current_user)
    )
  end

  def create
    @message = Message.new(
      sender_id: current_user.id,
      recipient: User.where(username: message_params[:recipient_username]).first,
      subject: message_params[:subject],
      body: message_params[:body]
    )

    if params[:conversation_id]
      @message.conversation = Conversation.find(params[:conversation_id])
    else
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