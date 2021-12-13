# frozen_string_literal: true

require 'rails_helper'

describe 'Update account', type: :system do
  before(:each) do
    login
  end

  context 'given the account page is visited' do
    it 'displays the account link' do
      visit edit_user_registration_path

      expect(find('nav')).to have_link('Account')
    end

    it 'displays the current password field' do
      visit edit_user_registration_path

      expect(page).to have_field('Enter your current password to save changes')
    end

    it 'displays the cancel my account button' do
      visit edit_user_registration_path

      expect(page).to have_button('Cancel my account')
    end
  end

  context 'given a valid current password' do
    it 'display successfully updated message' do
      user = build(:user, first_name: 'Example', last_name: 'Test', email: 'test123@example.com')
      update_account user, 'test1111'

      expect(page).to have_content 'Your account has been updated successfully.'
    end

    it 'update the account' do
      user = build(:user, first_name: 'Example')
      update_account user
      visit edit_user_registration_path

      expect(find('#user_first_name').value).to eq 'Example'
    end
  end

  context 'given no password' do
    it 'displays an error message' do
      visit edit_user_registration_path

      click_button 'Save'
      expect(find('#edit_user')).to have_selector('.error-message')
    end
  end

  context 'given an incorrect password' do
    it 'displays an error message' do
      user = build(:user, password: 'test1111')
      update_account user

      expect(find('#edit_user')).to have_selector('.error-message')
    end
  end
end
