require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  login_admin

  describe 'GET #show' do
    let(:user_to_show) { FactoryGirl.create(:user) }

    it 'responds successfully with an HTTP 200 status code' do
      get :show, params: { id: user_to_show.id }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      get :show, params: { id: user_to_show.id }
      expect(response).to render_template(:show)
    end
  end
end
