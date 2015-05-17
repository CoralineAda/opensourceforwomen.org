class PairProfilesController < ApplicationController
  before_action :require_login

  def index
    @pair_profile = current_user.pair_profile
    @pair_profiles = PairProfile.all#.excludes(id: current_user.pair_profile.id)
  end

  def create
    @pair_profile = PairProfile.new(profile_params)
    @pair_profile.user = current_user
    if @pair_profile.save
      redirect_to pair_profiles_path
    else
      flash[:error] = @pair_profile.errors.full_messages
      render 'new'
    end
  end

  def edit
    @pair_profile = current_user.pair_profile
  end

  def show
    @pair_profile = PairProfile.find(params[:id])
  end

  def new
    @pair_profile = PairProfile.new(user: current_user)
  end

  private

  def profile_params
    params.require(:pair_profile).permit(:languages)
  end

end