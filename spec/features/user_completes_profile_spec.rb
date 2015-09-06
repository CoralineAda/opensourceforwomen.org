require 'rails_helper'

describe 'User completes her profile' do

  before do
    sign_in_user
    Language.create(name: "Ruby")
  end

  it 'displays the profile form' do
    visit '/dashboards/1'
    click_link 'My Profile'
    expect(page).to have_content "Complete Your Profile"
  end

  it 'creates an extended profile' do
    visit '/dashboards/1'
    click_link 'My Profile'
    fill_in(:extended_profile_availability, with: "Saturday afternoons")
    check 'Ruby'
    click_button 'Save'
    expect(page).to have_content("Coraline's Profile")
    expect(User.last.extended_profile.availability).to eq("Saturday afternoons")
  end

end