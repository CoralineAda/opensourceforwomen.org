class UsersController < ApplicationController

  before_action :require_login, except: [:new, :create, :activate]

  def new
    @user = User.new(user_params)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(user_params[:email], user_params[:password])
      flash[:success] = 'Please check your email for account activation.'
      redirect_to sign_in_path
    else
      flash.now[:error] = @user.errors.full_messages
      render 'new'
    end
  end

  def activate
    if @user = User.load_from_activation_token(params[:id])
      @user.activate!
      flash[:success] = 'Your account was successfully activated. Please sign in.'
      redirect_to sign_in_path
    else
      flash[:warning] = 'Could not activate this account.'
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username)
  end

end
