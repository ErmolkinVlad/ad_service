require 'rails_helper'

RSpec.describe Advert, type: :model do


  describe '.set_archive' do
    context 'when published status is longer than 1 day' do
      it 'set it to archived' do
        advert = FactoryGirl.create(:advert)
        advert.moderate!
        advert.publish!
        advert.create_log(advert.user)
        log = advert.logs.last
        log.update_attribute(:time, Time.zone.now.ago(1.day))
        Advert.set_archive
        expect(Advert.last.status).to eql('archived')
      end
    end
  end

  describe 'scopes' do
    it 'returns all published adverts' do
      5.times { FactoryGirl.create(:advert, status: :published) }
      expect(Advert.published.count).to eql(5)
    end

    it 'returns all admin_available adverts' do
      2.times { FactoryGirl.create(:advert, status: :published) }
      2.times { FactoryGirl.create(:advert, status: :canceled) }
      2.times { FactoryGirl.create(:advert, status: :moderated) }
      2.times { FactoryGirl.create(:advert, status: :archived) }      
      expect(Advert.admin_available.count).to eql(6)
    end

    it 'returns all moderated adverts' do
      5.times { FactoryGirl.create(:advert, status: :moderated) }
      expect(Advert.moderated.count).to eql(5)
    end
  end

  describe '#create_log' do
    context 'when prev and current statuses are different' do
      it 'create log' do
        advert = FactoryGirl.create(:advert)
        advert.moderate!
        advert.create_log(advert.user, 'comment')
        expect(advert.logs.count).to eql 1
      end
    end

    context 'when prev and current statuses are the same' do
      it 'doesn\'t create log' do
        advert = FactoryGirl.create(:advert)
        advert.create_log(advert.user, 'comment')
        expect(advert.logs.count).to eql 0
      end
    end

  end

  it 'has a valid factory' do
    expect(build(:advert)).to be_valid
  end

  it 'is invalid without a title' do
    expect(build(:advert, title: nil)).to_not be_valid
  end

  context 'when title length is greater than 20' do
    it 'is invalid' do
      expect(build(:advert, title: 'a' * 21)).to_not be_valid
    end
  end

  it 'should allow valid values' do
    %w(recent moderated canceled published archived).each do |v|
      should allow_value(v).for(:status)
    end
  end

  it 'is not valid with a bad status' do
    expect { build(:advert, status: :other) }
      .to raise_error(ArgumentError)
      .with_message(/is not a valid status/)
  end

  it 'should allow valid values' do
    %w(Sale Buy Exchange Service Rent).each do |v|
      should allow_value(v).for(:ad_type)
    end
  end

  it 'is not valid with a bad ad_type' do
    expect { build(:advert, ad_type: :other) }
      .to raise_error(ArgumentError)
      .with_message(/is not a valid ad_type/)
  end

  it 'is invalid without a category' do
    expect(build(:advert, category: nil)).to_not be_valid
  end

  it 'is invalid without a ad_type' do
    expect(build(:advert, ad_type: nil)).to_not be_valid
  end

  it 'is invalid without a price' do
    expect(build(:advert, price: nil)).to_not be_valid
  end

  context 'when price less than 0' do
    it 'is invalid' do
      expect(build(:advert, price: -1)).to_not be_valid
    end
  end

  describe 'state transitions' do
    let(:advert) { Advert.new }

    it 'has default state' do
      expect(advert.status).to eql('recent')
    end

    context 'when there is not moderated state' do
      it 'should not allow publish event' do
        %w(recent canceled published archived).each do |st|
          advert.status = st
          expect(advert).to_not allow_transition_to(:published)
        end
      end

      it 'should not allow cancel event' do
        %w(recent canceled published archived).each do |st|
          advert.status = st
          expect(advert).to_not allow_transition_to(:canceled)
        end
      end
    end

    context 'when there is moderated state' do
      it 'should allow publish event' do
        expect(advert).to transition_from(:moderated).to(:published).on_event(:publish)
      end

      it 'should allow cancel event' do
        expect(advert).to transition_from(:moderated).to(:canceled).on_event(:cancel)
      end
    end


  end

end
