class Admin::AdminController < ApplicationController

  before_filter :ensure_admin

  def index
    @projects_count = Project.count
    @users_count = User.count
    @messages_count = Message.count
    @conversations_count = Conversation.count
    @mentors_count = ExtendedProfile.mentors.count
    @pair_partners_count = ExtendedProfile.pair_partners.count
  end

  private

  def ensure_admin
    redirect to "/" unless current_user.is_admin?
  end

end