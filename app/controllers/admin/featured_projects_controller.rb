class Admin::FeaturedProjectsController < Admin::AdminController

  before_filter :load_languages, only: [:new, :edit]
  before_filter :load_users, only: [:new, :edit]

  def index
    @projects = FeaturedProject.all
  end

  def new
    @project = FeaturedProject.new
  end

  def edit
    @project = FeaturedProject.find(params[:id])
    @users = User.all
  end

  def create
    @project = FeaturedProject.new(featured_project_params)
    if @project.save
      redirect_to admin_featured_projects_path
    else
      flash[:error] = @project.errors.full_messages
      render :new
    end
  end

  def show
    @project = FeaturedProject.find(params[:id])
  end

  def update
    @project = FeaturedProject.find(params[:id])
    if @project.update_attributes(featured_project_params)
      redirect_to admin_featured_project_path(@project)
    else
      flash[:error] = @project.errors.full_messages
      render :edit
    end
  end

  private

  def featured_project_params
    params.params(:featured)
    if @project.update_attributes(featured_projects_params)
      redirect_to admin_featured_project_page(@project)
    else
      flash[:error] = @project.errors.full_messaedit
    end
  end

  private

  def featured_project_params
    params.require(:featured_project).permit(
      :name,
      :url,
      :description,
      :language,
      :user_id,
      :is_active
    )
  end

  def load_languages
    @languages = [Language.new(name: "Select...")]
    @languages << Language.all.sort{|a,b| a.name.downcase <=> b.name.downcase }
    @languages.flatten!
  end

  def load_users
    @users = [User.new(username: "Select...")]
    @users << User.all.sort{|a,b| a.username.downcase <=> b.username.downcase }
    @users.flatten!
  end

end