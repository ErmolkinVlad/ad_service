require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST #create' do
    context 'with valid attributes' do
      it 'create new user' do
        post :create, params: { user: attributes_for(:user) }
        expect(User.count).to eq(1)
      end

      it 'responds successfully with an HTTP 200 status code' do
        post :create, params: { user: attributes_for(:user) }
        expect(response).to be_success
        expect(response).to have_http_status(204)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new user' do
        post :create, params: { user: attributes_for(:user, email: '1') }
        post :create, params: { user: attributes_for(:user, password: 111) }
        expect(User.count).to eq(0)
      end
    end
  end 

  describe 'user signed in' do
    let(:user) {FactoryGirl.create(:user)}
    before(:each) { sign_in user }
    after(:each)  { sign_out user}

    describe 'GET users/:id' do
      it 'should show adverts from user' do
        advert = FactoryGirl.create(:advert, user: user)
        get :show
        expect(assigns(:adverts)).to eq([advert])
      end

      it 'responds successfully with an HTTP 200 status code' do
        get :show
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    
      it 'renders the show template' do
        get :show
        expect(response).to render_template('show')
      end

      it 'render adverts' do
        adverts = Array.new(10){ FactoryGirl.create(:advert, user: user) }.sort_by { |ad| ad.created_at }
        adverts_in_page = Kaminari.paginate_array(adverts).page(1).per(10)
        post :show
        expect(assigns(:adverts).to_a).to eql(adverts_in_page)
      end

      it 'filter adverts by category' do
        category = FactoryGirl.create(:category, name: 'testing')
        adverts = Array.new(5) { FactoryGirl.create(:advert, user: user) }
        adverts += Array.new(5) { FactoryGirl.create(:advert, user: user, category: category)}
        adverts = adverts.select { |ad| ad.category == category }
        @params = { filter: { category: category.id.to_s, ad_type: '' }, format: 'js' }
        post :show, params: @params
        expect(assigns(:adverts).to_a).to eq(adverts)
      end

      it 'filter adverts by ad_type' do
        adverts = Array.new(10) { FactoryGirl.create(:advert, user: user) }
        adverts = adverts.select { |ad| ad.ad_type == 'Sale' }
        @params = { filter: { category: '', ad_type: 'Sale' }, format: 'js' }
        post :show, params: @params
        expect(assigns(:adverts).to_a).to eq(adverts)
      end

      it 'filter adverts both by category and ad_type' do
        adverts = Array.new(10) { FactoryGirl.create(:advert, user: user) }
        category = adverts.sample.category
        adverts = adverts.select { |ad| ad.ad_type == 'Sale' && ad.category == category }
        @params = {filter: { category: category.id.to_s, ad_type: 'Sale'}, format: 'js' }
        post :show, params: @params
        expect(assigns(:adverts).to_a).to eql(adverts)
      end
    end
  end

end
