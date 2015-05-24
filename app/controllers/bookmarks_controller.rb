class BookmarksController < ApplicationController

  before_action :require_login

  def create
    if params[:remove] == "true"
      current_user.projects.delete(Project.find(params[:project_id]))
      redirect_to project_path(params[:project_id])
    else
      current_user.projects << Project.find(params[:project_id])
      redirect_to project_path(params[:project_id])
    end
  end

end
