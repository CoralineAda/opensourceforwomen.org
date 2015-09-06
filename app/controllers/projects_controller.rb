class ProjectsController < ApplicationController

  before_action :require_login

  def index
    @languages = Language.all.order('name ASC')
    if params[:commit] && @language = Language.find_by(name: params[:commit].gsub(/ \(.+/, ''))
      @projects = Project.where(language: @language.name).sort_by(&:name)
    else
      @projects = []
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(
      name: project_params[:name],
      repo_url: project_params[:repo_url].strip,
      has_coc: project_params[:has_coc]
    )
    if @project.save
      @project.update
      redirect_to project_path(@project)
    else
      flash[:error] = @project.errors.full_messages
      render 'new'
    end
  end

  def show
    @project = Project.find(params[:id])
    @comments = @project.project_comments.order('created_at ASC')
  end

  private

  def project_params
    params.require(:project).permit(
      :name,
      :has_coc,
      :repo_url
    )
  end

end
