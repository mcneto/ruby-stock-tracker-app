# frozen_string_literal: true

require 'rails_helper'

describe 'Sign in', type: :system do
  context 'given valid credentials' do
    it 'displays successful sign in message' do
      sign_in_ui
      expect(page).to have_content 'Signed in successfully.'
    end

    it 'redirect to the main screen' do
      sign_in_ui
      expect(page).to have_current_path(root_path)
    end
  end

  context 'given no inputs' do
    it 'does not redirect to the main screen' do
      visit root_path

      click_button 'Log in'
      expect(page).to have_current_path(new_user_session_path)
    end
  end

  context 'given an invalid email input' do
    it 'does not redirect to the main screen' do
      sign_in_ui 'test@example', ''
      expect(page).to have_current_path(new_user_session_path)
    end
  end

  context 'given an invalid password input' do
    it 'does not redirect to the main screen' do
      sign_in_ui '', 'test12'
      expect(page).to have_current_path(new_user_session_path)
    end
  end
end
