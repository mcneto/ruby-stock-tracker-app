# frozen_string_literal: true

require 'rails_helper'

describe 'Registration', type: :system do
  context 'given the registration page is visited' do
    before(:each) do
      visit new_user_registration_path
    end

    it 'displays the first name field' do
      expect(page).to have_field('First Name')
    end

    it 'displays the last name field' do
      expect(page).to have_field('Last Name')
    end

    it 'displays the email field' do
      expect(page).to have_field('Email')
    end

    it 'displays the password field' do
      expect(page).to have_field('Password')
    end

    it 'displays the password confirmation field' do
      expect(page).to have_field 'Password Confirmation'
    end
  end

  context 'given the valid inputs' do
    it 'displays successful register message' do
      sign_up_user 'test@example.com', 'test1234', 'test1234'
      expect(page).to have_content 'Welcome! You have signed up successfully.'
    end

    it 'create a new user' do
      sign_up_user 'test@example.com', 'test1234', 'test1234'
      expect(User.count).to eq(1)
    end
  end

  context 'given no inputs' do
    it 'does not create a new user' do
      visit new_user_registration_path

      click_button 'Create an Account'
      expect(User.count).to eq(0) # equal 1 when new user was created
    end
  end

  context 'given an invalid email input' do
    it 'does not create a new user' do
      sign_up_user 'test.com', 'test1234', 'test1234'
      expect(User.count).to eq(0) # equal 1 when new user was created
    end
  end

  context 'given an invalid password input' do
    it 'displays an error message' do
      sign_up_user 'test@example.com', 'test1', 'test1'
      expect(find('form')).to have_selector('.error-message')
    end
  end

  context 'given a wrong password confirmation ' do
    it 'displays an error message' do
      sign_up_user 'test@example.com', 'test1234', 'test1246'
      expect(find('form')).to have_selector('.error-message')
    end
  end
end
