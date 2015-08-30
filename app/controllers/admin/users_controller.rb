class Admin::UsersController < Admin::AdminController

  def index
    @users = User.all.order("email ASC")
  end

  def show
    @user = User.find(params[:id])
    @extended_profile = @user.extended_profile
  end

end