FactoryGirl.define do
  factory :advert do
    title         { Faker::Commerce.product_name[0, 19] }
    description   { Faker::Hipster.paragraph }
    price         { Faker::Commerce.price }
    category      { Category.find_or_create_by(name: Faker::Commerce.department) }
    ad_type       { Advert.ad_types.keys.sample }
    user
  end
end