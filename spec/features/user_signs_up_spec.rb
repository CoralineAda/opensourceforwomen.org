require 'rails_helper'

describe 'User signs up' do

  it 'displays the signup form' do
    visit '/'
    click_link 'Sign Up'
    expect(page).to have_content "Create a New Account"
  end

  it 'signs up a user' do
    visit '/users/new'
    fill_in 'user_requested_username', with: 'Coraline'
    fill_in 'user_email', with: 'coraline@idolhands.com'
    fill_in 'user_password', with: 'foo123456'
    fill_in 'user_password_confirmation', with: 'foo123456'
    check 'user_accepts_coc'
    check 'user_accepts_terms'
    click_button 'Create Account'
    mail = ActionMailer::Base.deliveries.last
    expect(mail.body.to_s).to include("Coraline")
    expect(User.count).to eq 1
  end

end