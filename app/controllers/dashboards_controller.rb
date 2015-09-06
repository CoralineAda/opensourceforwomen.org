class DashboardsController < ApplicationController

  before_action :require_login

  def show
    @dashboard = Dashboard.new(user: current_user)
  end

end
