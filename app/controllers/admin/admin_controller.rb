class Admin::AdminController < ApplicationController

  before_filter :ensure_admin

  def index
    @projects_count = Project.count
    @users_count = User.count
    @messages_count = Message.count
    @conversations_count = Conversation.count
  end

  private

  def ensure_admin
    redirect to "/" unless current_user.is_admin?
  end

end