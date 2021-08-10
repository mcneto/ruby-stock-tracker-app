# frozen_string_literal: true

module AccountHelpers
  def update_account(user, password = nil)
    visit edit_user_registration_path

    find('#user_first_name').set('').set(user.first_name)
    fill_in :user_last_name, with: user.last_name
    fill_in :user_email, with: user.email
    fill_in :user_password, with: password
    fill_in :user_password_confirmation, with: password
    fill_in :user_current_password, with: user.password

    click_button 'Save'
  end
end
