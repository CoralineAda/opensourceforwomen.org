class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  def not_authenticated
    flash[:warning] = 'You must be signed in to access this page.'
    redirect_to sign_in_path
  end

end
