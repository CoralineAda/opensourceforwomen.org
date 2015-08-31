require 'rails_helper'

describe 'User signs in' do

  it 'displays the sign-in form' do
    visit '/'
    click_link 'Sign In'
    expect(page).to have_content "Sign In to Your Account"
  end

end