# frozen_string_literal: true

require 'rails_helper'

describe 'Sign out', type: :system do
  context 'given the sign-out link is clicked' do
    it 'redirect to the sign-in page' do
      login
      visit root_path
      click_link 'Sign Out'
      expect(page).to have_current_path(new_user_session_path)
    end
  end
end
