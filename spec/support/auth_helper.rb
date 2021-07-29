# frozen_string_literal: true

module AuthHelpers
  def sign_in_ui(user = nil)
    user ||= FactoryBot.create(:user)
    visit root_path

    fill_in :user_email, with: user.email
    fill_in :user_password, with: user.password

    click_button 'Log in'
  end

  def sign_in_user
    @request.env['devise.mapping'] = Devise.mappings[:user]
    user = FactoryBot.create(:user)
    sign_in(user)
  end

  def login
    user = FactoryBot.create(:user)
    sign_in(user)
  end

  def sign_up_user(email, password, confirmation)
    visit new_user_registration_path

    fill_in :user_first_name, with: Faker::Name.first_name
    fill_in :user_last_name, with: Faker::Name.last_name
    fill_in :user_email, with: email
    fill_in :user_password, with: password
    fill_in :user_password_confirmation, with: confirmation

    click_button 'Create an Account'
  end
end
