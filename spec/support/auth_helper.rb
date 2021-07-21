# frozen_string_literal: true

module AuthHelpers
  def sign_up_user(email, password, confirmation)
    visit new_user_registration_path

    fill_in :user_first_name, with: Faker::Name.first_name
    fill_in :user_last_name, with: Faker::Name.last_name
    fill_in :user_email, with: email
    fill_in :user_password, with: password
    fill_in :user_password_confirmation, with: confirmation

    click_button 'Sign up'
  end
end
