# frozen_string_literal: true

require 'rails_helper'

describe 'Sign in', type: :system do
  context 'given the navigation bar' do
    it 'displays the sign-in link' do
      visit root_path
      expect(find('nav')).to have_link('Sign In')
    end
  end

  context 'given the sign-in page is visited' do
    it 'displays the email field' do
      visit new_user_registration_path
      expect(page).to have_field('Email')
    end

    it 'displays the password field' do
      visit new_user_registration_path
      expect(page).to have_field('Password')
    end
  end

  context 'given valid credentials' do
    it 'displays successful sign in message' do
      sign_in_ui
      expect(page).to have_content 'Signed in successfully.'
    end

    it 'redirects to the main screen' do
      sign_in_ui
      expect(page).to have_current_path(root_path)
    end
  end

  context 'given no inputs' do
    it 'does not redirect to the main screen' do
      visit new_user_session_path

      click_button 'Log in'
      expect(page).to have_current_path(new_user_session_path)
    end
  end

  context 'given an invalid email input' do
    it 'does not redirect to the main screen' do
      user = build(:user, email: 'test@example')
      sign_in_ui user
      expect(page).to have_current_path(new_user_session_path)
    end
  end

  context 'given an invalid password input' do
    it 'does not redirect to the main screen' do
      user = build(:user, password: 'test12')
      sign_in_ui user
      expect(page).to have_current_path(new_user_session_path)
    end
  end
end
