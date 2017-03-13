FactoryGirl.define do
  factory :user do
    email         { Faker::Internet.email }
    password      { '123123' }
    role          { :user }
    avatar        { Faker::Avatar.image }

    factory :admin do
      role  :admin
    end
  end
end