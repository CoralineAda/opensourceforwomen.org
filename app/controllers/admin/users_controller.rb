class Admin::UsersController < Admin::AdminController

  def index
    @users = User.all.order("email ASC")
  end

  def show
    @user = User.find(params[:id])
    @extended_profile = @user.extended_profile || ExtendedProfile.new
    @abuse_reports_cited = AbuseReport.where(offender_id: @user.id)
    @abuse_reports_filed = AbuseReport.where(reporter_id: @user.id)
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:info] = 'The user account has been updated.'
      redirect_to admin_user_path(@user)
    else
      flash.now[:error] = @user.errors.full_messages
      render 'show'
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :is_frozen
    )
  end

end