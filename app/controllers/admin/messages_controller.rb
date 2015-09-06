class Admin::MessagesController < Admin::AdminController

  def show
    @user = User.find(params[:user_id])
    @message = Message.find(params[:id])
    @conversation = @message.conversation
  end

end