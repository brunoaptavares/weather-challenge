FactoryGirl.define do
  factory :user, class: User do
    id { SecureRandom.uuid }
    email { "teste@teste.com.br" }
    password { Faker::Number.number(20).to_s }
  end
end
