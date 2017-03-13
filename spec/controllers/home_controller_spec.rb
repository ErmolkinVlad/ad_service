require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET #index' do

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
      5.times { FactoryGirl.create(:advert, status: :published)}
      get :index
      expect(assigns(:adverts).to_a.count).to eq 5 
    end

    it 'filters and sorts adverts' do
      adverts = Array.new(5) { FactoryGirl.create(:advert, status: :published) }
      category = adverts.sample.category
      ad_type = adverts.sample.ad_type
      adverts += Array.new(5) { FactoryGirl.create(:advert, status: :published, ad_type: ad_type, category: category)  }
      adverts = adverts.select { |ad| ad.ad_type == ad_type && ad.category == category }
      adverts.sort_by!(&:price)
      get :index, params: {xhr: true, filter: {ad_type: Advert.ad_types[ad_type].to_s, category: category.id.to_s}, q: {s: 'price asc'}}
      expect(assigns(:adverts).to_a).to eq adverts
    end

  end
end