require 'rails_helper'

RSpec.feature 'Gravatar' do
  context 'a user with an email address' do
    background do
      sign_in_user
    end

    given(:user) { User.first }

    scenario "displays gravatar on Dashboard" do
      visit "/dashboards/#{user.id}"

      expect(page.find('.avatar')['src']).to have_content /https:\/\/secure.gravatar.com/
    end

    scenario "displays gravatar on Profile Page" do
      profile = user.create_extended_profile!
      visit "/extended_profiles/#{profile.id}"

      expect(page.find('.avatar')['src']).to have_content /https:\/\/secure.gravatar.com/
    end
  end
end

