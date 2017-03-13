require 'rails_helper'

RSpec.describe Admin::AdvertsController, type: :controller do
  let(:user) { FactoryGirl.create(:user, role: :admin) }
  let(:advert) { FactoryGirl.create(:advert, user: user, status: :moderated) }
  before(:each) { sign_in user }
  after(:each)  { sign_out user}

  describe 'GET #index' do
    let(:advert) { FactoryGirl.create(:advert, user: user) }

    it 'responds successfully with an HTTP 200 status code' do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'renders adverts' do
      5.times { FactoryGirl.create(:advert, status: :moderated) }
      FactoryGirl.create(:advert, status: :published)
      get :index
      expect(assigns(:adverts).to_a.count).to eql 5
    end

    it 'renders users' do
      5.times { FactoryGirl.create(:user) }
      get :index
      # 5 users created here + 1 user created as admin
      expect(assigns(:users).to_a.count).to eql 6
    end

    it 'renders categories' do
      5.times { |i| FactoryGirl.create(:category, name: i.to_s) }
      get :index
      expect(assigns(:categories).to_a.count).to eql 5
    end
  end


  describe 'GET #show' do
    let(:advert) { FactoryGirl.create(:advert, user: user) }

    it 'responds successfully with an HTTP 200 status code' do
      get :show, params: { id: advert.id }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      get :show, params: { id: advert.id }
      expect(response).to render_template(:show)
    end
  end



  describe 'PATCH #update' do
    it 'accepts advert' do
      put :update, params: { advert: {status: :published}, id: advert.id.to_s, format: 'js' }
      expect(Advert.find(advert.id).published?).to be true
    end

    it 'rejects advert' do
      put :update, params: { advert: {status: :canceled}, id: advert.id.to_s, format: 'js' }
      expect(Advert.find(advert.id).canceled?).to be true
    end

    it 'creates comment' do
      put :update, params: { advert: { status: :published}, id: advert.id.to_s, format: 'js' }
      expect(Advert.find(advert.id).logs.count).to eql 1
    end
  end
end