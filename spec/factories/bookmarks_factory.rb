FactoryGirl.define do
  factory :bookmark, class: Bookmark do
    city_name { Faker::Name.name }

    association(:user, factory: :user)
  end
end
