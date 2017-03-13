FactoryGirl.define do
  factory :identity do
    provider          { Faker::Internet.domain_name }
    uid               { Faker::Internet.password(8) }
    user
  end
end