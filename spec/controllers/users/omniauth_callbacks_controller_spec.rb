require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  describe 'GET #facebook' do
    before do
      mock_auth_hash
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
      request.env["devise.mapping"] = Devise.mappings[:user]
    end
    
    it 'creates user via omniauth' do
      expect { get :facebook }.to change { User.count }.by(1)
    end
  end

  describe 'GET #twitter' do
    before do
      mock_auth_hash
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
      request.env["devise.mapping"] = Devise.mappings[:user]
    end
    
    it 'creates user via omniauth' do
      expect { get :twitter }.to change { User.count }.by(1)
    end
  end

  describe 'GET #vkontakte' do
    before do
      mock_auth_hash
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:vkontakte]
      request.env["devise.mapping"] = Devise.mappings[:user]
    end
    
    it 'creates user via omniauth' do
      expect { get :vkontakte }.to change { User.count }.by(1)
    end
  end


end