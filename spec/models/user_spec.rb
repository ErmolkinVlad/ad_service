require 'rails_helper'

RSpec.describe :user, type: :model do
  
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

describe '.find_for_oauth' do
  context 'when new user' do
    it 'should create user' do
      mock_auth_hash
      User.find_for_oauth(OmniAuth.config.mock_auth[:twitter])
      expect(User.last.email).to eql 'mock@gmail.com'
    end
  end

  context 'when user exist' do
    it 'should find user' do
      user = FactoryGirl.create(:user)
      user.update_attribute(:email, 'mock@gmail.com')
      expect(User.find_for_oauth(OmniAuth.config.mock_auth[:twitter])).to eql user
    end
  end

  context 'when identity exist' do
    it 'should find user by identity' do
      identity = Identity.find_for_oauth(OmniAuth.config.mock_auth[:twitter])
      user = FactoryGirl.create(:user)
      identity.user = user
      expect(User.find_for_oauth(OmniAuth.config.mock_auth[:twitter]).identities.last).to eql identity
    end
  end

end

  describe '#role?' do
    let(:user) { build(:user, role: :user) }

    it 'should be true if there are same roles' do
      expect(user.role?('user')).to be true
    end

    it 'should be false is there are different roles' do
      expect(user.role?('admin')).to be false
    end
  end
end