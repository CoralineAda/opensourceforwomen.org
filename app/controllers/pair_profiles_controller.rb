class PairProfilesController < ApplicationController
  before_action :require_login
  before_action :scope_languages, only: [:new, :create, :update, :edit
  ]
  def index
    @pair_profile = current_user.pair_profile
    @pair_profiles = PairProfile.all.excludes(id: current_user.pair_profile.id)
  end

  def create
    @pair_profile = PairProfile.new({user: current_user}.merge(profile_params))
    if profile_params[:other_language].present? && language = Language.create(name: profile_params[:other_language])
      @pair_profile.languages << language
    end
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

  def update
    @pair_profile = current_user.pair_profile
    @pair_profile.update_attributes(profile_params)
    if profile_params[:other_language].present? && language = Language.create(name: profile_params[:other_language])
      @pair_profile.languages << language
    end
    flash[:info] = "Your profile has been updated."
    redirect_to pair_profiles_path
  end

  private

  def profile_params
    params.require(:pair_profile).permit(
      :other_language,
      :availability,
      :time_zone,
      :skill_level,
      :special_interests,
      { language_ids: [] },
      :notes
    )
  end

  def scope_languages
    @languages = Language.all.sort_by(&:name)
  end

end