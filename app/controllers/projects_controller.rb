class ProjectsController < ApplicationController

  before_action :require_login
  before_filter :load_languages, only: [:new, :create]

  def index
    @languages = Language.all.order('name ASC')
    @languages = @languages.reject do |language|
      Project.where("language = '#{language.name}'").size ==  0
    end
    if params[:commit] && @language = Language.find_by(name: params[:commit].gsub(/ \(.+/, ''))
      @projects = Project.where(language: @language.name).order('name ASC')
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
      has_coc: project_params[:has_coc],
      language: project_params[:language] == "Select..." ? "" : project_params[:language]
    )
    if project_params[:other_language].present? && language = Language.find_or_create_by(name: project_params[:other_language])
      @project.language = language.name
    end
    if @project.save
      @project.update
      @project.save
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

  def load_languages
    @languages = [Language.new(name: "Select...")]
    @languages << Language.all.sort{|a,b| a.name.downcase <=> b.name.downcase }
    @languages.flatten!
  end

  def project_params
    params.require(:project).permit(
      :name,
      :has_coc,
      :repo_url,
      :language,
      :other_language
    )
  end

end
