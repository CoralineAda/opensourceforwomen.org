class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:email])
    if login(params[:email], params[:password])
      if @user.can_sign_in?
        flash[:success] = "Welcome back, #{@user.username}!"
        redirect_to dashboard_path(1)
      else
        flash.now[:warning] = 'Your account has been frozen pending an abuse investigation.'
        render 'new'
      end
    else
      @user = User.new
      flash.now[:warning] = 'E-mail and/or password is incorrect.'
      render 'new'
    end
  end

  def destroy
    logout
    flash[:success] = 'You have been signed out.'
    redirect_to root_path
  end

end