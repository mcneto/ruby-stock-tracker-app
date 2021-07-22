# frozen_string_literal: true

require 'rails_helper'

describe PagesController, type: :controller do
  describe 'GET #index' do
    context 'when unauthorized user access to main screen' do
      it 'returns a redirect response' do
        get :index
        expect(response).to have_http_status(:redirect)
        # expect(response).to have_http_status(302) # Expects a HTTP Status code of 302
      end
    end

    context 'when signed in user access to main screen' do
      sign_in_user

      it 'returns a success response' do
        get :index
        expect(response).to have_http_status(:success)
        # expect(response).to have_http_status(302) # Expects a HTTP Status code of 302
      end
    end
  end
end
