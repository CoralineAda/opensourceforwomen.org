class MessagesController < ApplicationController

  before_filter :scope_recipient, except: [:index, :show, :destroy]
  before_action :require_login

  def index
    @conversations = current_user.conversations.sort_by(&:created_at).reverse.uniq
  end

  def new
    in_reply_to = params[:message_id] && current_user.messages.find(params[:message_id])
    if in_reply_to
      @conversation = in_reply_to.conversation
    else
      @recipient ||= User.find(params[:recipient_id]) if params[:recipient_id]
      @recipient ||= User.new
      @conversation = Conversation.new
      @conversation.participants << current_user
      @conversation.participants << @recipient
      @converation.save
    end
    @recipient = @conversation.other_participant(current_user)
    @message = Message.new(
      conversation: @conversation,
      recipient: @recipient
    )
  end

  def create
    if message_params[:recipient_id].present?
      recipient = User.find(message_params[:recipient_id])
    else
      recipient = User.find_by(username: message_params[:recipient_username])
    end
    if recipient.nil? || recipient == current_user
      @conversation = Conversation.new
      @message = Message.new(
        sender_id: current_user.id,
        recipient: params[:recipient_username],
        body: message_params[:body]
      )
      flash.now[:error] = "No member found with that username!"
      render 'new' and return
    end
    @message = Message.new(
      sender_id: current_user.id,
      recipient_id: recipient.id,
      body: message_params[:body],
      conversation_id: message_params[:conversation_id]
    )
    unless @message.conversation
      conversation = current_user.conversation_with(recipient) || Conversation.create
      conversation.participants = [current_user, @message.recipient]
      conversation.save
      @message.conversation = conversation
    end

    if @message.save
      flash[:success] = 'Message sent successfully.'
      MessageWorker.perform_in(5.minutes, @message.id)
      redirect_to user_messages_path(current_user)
    else
      flash.now[:error] = @message.errors.full_messages
      render 'new'
    end
  end

  def show
    @message = Message.find(params[:id])
    if @message.recipient_id == current_user.id || @message.sender_id == current_user.id
      @conversation = @message.conversation
      @conversation.messages.map{|m| m.update_attribute(:is_read, true) if m.recipient = current_user}
    else
      redirect_to :index
    end
  end

  private

  def message_params
    params[:message]
  end

  def scope_recipient
    @recipient = params[:recipient_id] ? User.find(params[:recipient_id]) : User.new
  end

end