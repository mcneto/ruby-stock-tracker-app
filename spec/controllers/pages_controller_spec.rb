# frozen_string_literal: true

require 'rails_helper'

describe PagesController, type: :controller do
  describe 'GET #index' do
    context 'given unauthorized user tries to access the main page' do
      it 'redirects to the sign-in page' do
        get :index
        expect(response).to redirect_to(:new_user_session)
      end
    end

    context 'given authorized user tries to access the main page' do
      it 'returns a success response' do
        sign_in_user
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end
end
