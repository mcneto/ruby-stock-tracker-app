# frozen_string_literal: true

require 'rails_helper'

describe PagesController, type: :controller do
  describe 'GET #index' do
    context 'when unauthorized user access to main screen' do
      it 'returns a redirect response' do
        get :index
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'when signed in user access to main screen' do
      it 'returns a success response' do
        sign_in_user
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end
end
