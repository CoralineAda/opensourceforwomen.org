class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.from(project_params[:repo_url])
    if @project.valid?
      redirect_to projects_path
    end
  end

  private

  def project_params
    params.require(:project).permit(:repo_url)
  end

end