# FIXME add password reset
class UsersController < ApplicationController

  before_action :require_login, except: [:new, :create, :activate]

  def new
    @user = User.new
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

  def update
    @user = current_user
    if user_params[:password].empty?
      user_params.delete('password')
      user_params.delete('password_confirmation')
    end

    if @user.update_attributes(user_params)
      flash[:info] = 'Your account has been updated.'
      redirect_to root_path
    else
      flash.now[:error] = @user.errors.full_messages
      render 'show'
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

  def show
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      :username,
      :accepts_coc,
      :accepts_terms,
      :twitter_handle,
      :github_username,
      :subscribe_me
    )
  end

end
