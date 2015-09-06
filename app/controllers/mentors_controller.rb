class MentorsController < ApplicationController

  before_action :require_login

  def index
    @extended_profile = current_user.extended_profile
    if current_user.extended_profile
      @mentors = ExtendedProfile.mentors - [current_user.extended_profile]
    else
      @mentors = ExtendedProfile.mentors
    end
  end

end