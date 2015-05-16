class BookmarksController < ApplicationController

  before_action :require_login

  def create
    current_user.projects << Project.find(params[:project_id])
    redirect_to project_path(params[:project_id])
  end

end
