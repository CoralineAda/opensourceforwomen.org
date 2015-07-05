class ExtendedProfilesController < ApplicationController
  before_action :require_login
  before_action :scope_languages, only: [:new, :create, :update, :edit]

  def index
    @extended_profile = current_user.extended_profile
    if current_user.extended_profile
      @extended_profiles = ExtendedProfile.all.excludes(id: current_user.extended_profile.id)
    else
      @extended_profiles = ExtendedProfile.all
    end
  end

  def create
    @extended_profile = ExtendedProfile.new({user: current_user}.merge(profile_params))
    if profile_params[:other_language].present? && language = Language.create(name: profile_params[:other_language])
      @extended_profile.languages << language
    end
    if @extended_profile.save
      redirect_to extended_profiles_path
    else
      flash[:error] = @extended_profile.errors.full_messages
      render 'new'
    end
  end

  def edit
    @extended_profile = current_user.extended_profile
  end

  def show
    @extended_profile = ExtendedProfile.find(params[:id])
  end

  def new
    @extended_profile = ExtendedProfile.new(user: current_user)
  end

  def update
    @extended_profile = current_user.extended_profile
    @extended_profile.update_attributes(profile_params)
    if profile_params[:other_language].present? && language = Language.create(name: profile_params[:other_language])
      @extended_profile.languages << language
    end
    flash[:info] = "Your profile has been updated."
    redirect_to extended_profiles_path
  end

  private

  def profile_params
    params.require(:extended_profile).permit(
      :other_language,
      :availability,
      :time_zone,
      :skill_level,
      :special_interests,
      :is_mentor,
      :is_pair_partner,
      { language_ids: [] },
      :notes
    )
  end

  def scope_languages
    @languages = Language.all.sort_by(&:name)
  end

end