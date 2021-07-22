# frozen_string_literal: true

require 'rails_helper'

describe 'Sign out', type: :system do
  context 'given the sign out option is clicked' do
    it 'redirect to sign in screen' do
      login
      visit root_path
      click_link 'Sign Out'
      expect(page).to have_current_path(new_user_session_path)
    end
  end
end
