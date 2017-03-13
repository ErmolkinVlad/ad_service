require 'rails_helper'

RSpec.describe AdvertsController, type: :controller do
  let(:user) {FactoryGirl.create(:user)}
  let(:advert) { FactoryGirl.create(:advert, user: user) }
  before(:each) { sign_in user }
  after(:each)  { sign_out user}

  describe 'GET #show' do
    let(:advert) { FactoryGirl.create(:advert, user: user) }

    it 'responds successfully with an HTTP 200 status code' do
      get :show, params: {user_id: user.id, id: advert.id }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      get :show, params: {user_id: user.id, id: advert.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'responds successfully with an HTTP 200 status code' do
      get :new, params: {user_id: user.id}
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the new template' do
      get :new, params: {user_id: user.id}
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    let(:advert) { FactoryGirl.create(:advert, user: user) }

    it 'responds successfully with an HTTP 200 status code' do
      get :edit, params: {user_id: user.id, id: advert.id }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the edit template' do
      get :edit, params: {user_id: user.id, id: advert.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    let(:category) { FactoryGirl.create(:category) }

    context 'with valid attributes' do
      it 'create new advert' do
        post :create, params: { user_id: user.id, advert: attributes_for(:advert, category_id: category.id) }
        expect(Advert.count).to eq(1)
      end

      it 'responds successfully with an HTTP 200 status code' do
        post :create, params: { user_id: user.id, advert: attributes_for(:advert, category_id: category.id) }
        expect(response).to have_http_status(302)
        expect(subject).to redirect_to(user)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new advert' do
        post :create, params: { user_id: user.id, advert: attributes_for(:advert, category_id: category.id, title: '') }
        expect(Advert.count).to eq(0)
      end
    end
  end

  describe 'PATCH #update' do
    let(:category) { FactoryGirl.create(:category) }

    context 'with valid attributes' do
      it 'update advert' do
        post :update, params: { user_id: user.id, id: advert.id, advert: attributes_for(:advert, title: 'new_title') }
        expect(Advert.find(advert.id).title).to eq('new_title')
      end

      it 'responds successfully with an HTTP 200 status code' do
        post :update, params: { user_id: user.id, id: advert.id, advert: attributes_for(:advert) }
        expect(response).to have_http_status(302)
        expect(subject).to redirect_to([user, advert])
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new advert' do
        post :update, params: { user_id: user.id, id: advert.id, advert: attributes_for(:advert, title: '') }
        expect(response).to render_template(:edit)
      end
    end
  end 

  describe 'GET #search_index' do

    it 'finds adverts' do
      ad = FactoryGirl.create(:advert, title: 'test', status: :published)
      get :search_index, params: { utf8: '✓', q: {title_or_description_cont: 'test'} }
      expect(assigns(:adverts).to_a).to eql [ad]
    end

    it 'has no matches' do
      ad = FactoryGirl.create(:advert, title: 'no_matches', description: 'no_matches')
      get :search_index, params: { utf8: '✓', q: {title_or_description_cont: 'test'} }
      expect(assigns(:advert).to_a.count).to eql 0
    end
  end

  describe 'POST #make_archived' do
    it 'makes archived' do
      ad = FactoryGirl.create(:advert, status: :recent)
      post :make_archived, params: { format: 'js', user_id: user.id.to_s, id: ad.id.to_s }
      expect(Advert.find(ad.id).status).to eql 'archived'
    end
  end

  describe 'POST #make_moderated' do
    it 'makes moderated' do
      ad = FactoryGirl.create(:advert, status: :recent)
      post :make_moderated, params: { format: 'js', user_id: user.id.to_s, id: ad.id.to_s }
      expect(Advert.find(ad.id).status).to eql 'moderated'
    end
  end

  describe 'GET #history' do
    it 'responds successfully with an HTTP 200 status code' do
      get :history, params: { user_id: user.id, id: advert.id}
      expect(response).to have_http_status(200)
      expect(response).to render_template(:history)
    end

    it 'render logs' do
      advert.moderate!
      advert.create_log(advert.user)
      get :history, params: { user_id: user.id, id: advert.id}
      expect(assigns(:logs).to_a.count).to eq 1
    end
  end

end