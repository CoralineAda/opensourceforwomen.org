class ProjectCommentsController < ApplicationController

  before_action :require_login

  def create
    comment = ProjectComment.create(
      comment: params[:comment],
      project_id: params[:project_id],
      user: current_user
    )
    redirect_to Project.find(params[:project_id])
  end

end