class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    if login(params[:email], params[:password])
      flash[:success] = 'Welcome back!'
      redirect_to root_path
    else
      @user = User.new
      flash.now[:warning] = 'E-mail and/or password is incorrect.'
      render 'new'
    end
  end

  def destroy
    logout
    flash[:success] = 'You have been signed out.'
    redirect_to log_in_path
  end

  # def user_params
  #   params.require(:user).permit(:email, :password, :password_confirmation, :username)
  # end

end