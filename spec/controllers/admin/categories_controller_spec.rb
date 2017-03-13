require 'rails_helper'

RSpec.describe Admin::CategoriesController, type: :controller do
  let(:user) { FactoryGirl.create(:user, role: :admin) }
  let(:advert) { FactoryGirl.create(:advert, user: user, status: :moderated) }
  before(:each) { sign_in user }
  after(:each)  { sign_out user}

  describe 'POST #create' do
    context 'when valid attributes' do
      it 'creates category' do
        post :create, params: { category: { name: 'test' }, format: 'js' }
        expect(Category.where(name: 'test').first).to_not eql nil
      end
    end

    context 'when invalid attributes' do
      it 'doesn\'t create category' do
        post :create, params: { category: { name: '' } }
        expect(Category.all.count).to eql 0
      end
    end
  end

  describe 'PUT #update' do
    let(:category) { Category.create(name: 'test') }

    context 'when valid attributes' do
      it 'updates category' do
        put :update, params: { id: category.id, category: { name: 'new_test' }, format: 'js' }
        expect(Category.where(name: 'new_test').first).to_not eql nil
      end
    end

    context 'when invalid attributes' do
      it 'doesn\'t update category' do
        put :update, params: { id: category.id, category: { name: '' } }
        expect(Category.where(name: 'test').first).to_not eql nil
      end
    end
  end
end