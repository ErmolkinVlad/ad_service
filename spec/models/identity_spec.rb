require 'rails_helper'

RSpec.describe :identity, type: :model do
  
  describe '.find_for_oauth' do
    it 'should find existed identity' do
      identity = FactoryGirl.create :identity
      oauth = OmniAuth::AuthHash.new({
                                        :provider => identity.provider,
                                        :uid => identity.uid
                                      })
      expect(Identity.find_for_oauth(oauth)).to eql identity
    end

    it 'should create identity if not exist' do
      oauth = OmniAuth::AuthHash.new({
                                :provider => 'twitter',
                                :uid => '123545'
                              })
      Identity.find_for_oauth(oauth)
      expect(Identity.where(provider: 'twitter', uid: '123545').present?).to eql true
    end
  end

  it 'has a valid factory' do
    expect(build(:identity)).to be_valid
  end

  it 'is invalid with without a provider' do
    expect(build(:identity, provider: nil)).to_not be_valid
  end

  it 'is invalid with without a uid' do
    expect(build(:identity, uid: nil)).to_not be_valid
  end

  context 'in provider scope' do
    it 'is invalid with not uniq uid' do
      identity1 = FactoryGirl.create(:identity)
      expect(build(:identity, provider: identity1.provider, uid: identity1.uid)).to_not be_valid
    end
  end

  it 'is valid with the same uid' do
    id1 = FactoryGirl.create :identity
    expect(build(:identity, uid: id1.uid)).to be_valid
  end
end