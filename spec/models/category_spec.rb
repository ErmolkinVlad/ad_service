require 'rails_helper'

RSpec.describe :category, type: :model do
  
  it 'has a valid factory' do
    expect(build(:category)).to be_valid
  end

  it 'is invalid with without a name' do
    expect(build(:category, name: nil)).to_not be_valid
  end

  it 'is invalid with not uniq name' do
    category1 = Category.create(name: 'cat')
    expect(Category.create(name: 'cat')).to_not be_valid
  end
end