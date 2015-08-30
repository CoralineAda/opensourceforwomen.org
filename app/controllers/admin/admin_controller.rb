class Admin::AdminController < ApplicationController

  before_filter :ensure_admin

  private

  def ensure_admin
    redirect to "/" unless current_user.is_admin?
  end

end