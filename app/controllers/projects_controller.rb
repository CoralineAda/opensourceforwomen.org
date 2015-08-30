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

  def show
    @project = Project.find(params[:id])
    @comments = @project.project_comments.order('created_at ASC')
  end

end
