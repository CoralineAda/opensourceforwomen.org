class PasswordResetsController < ApplicationController

  skip_before_filter :require_login

  def new
    @user = User.new(email: params[:email])
  end

  def create
    if @user = User.where(email: params[:email]).first
      @user.deliver_reset_password_instructions!
      redirect_to(root_path, :notice => 'Password reset instructions have been sent to your email.')
    else
      flash.now[:info] = "No user could be found with that email address."
      render :new
    end
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      not_authenticated
      return
    end
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      not_authenticated
      return
    end

    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password!(params[:user][:password])
      redirect_to(sign_in_path, :notice => 'Your password was successfully updated.')
    else
      render :action => "edit"
    end
  end
end
