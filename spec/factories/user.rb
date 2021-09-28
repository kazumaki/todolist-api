FactoryBot.define do
  factory :user do
    email { Faker::String.random(length: 5) }
  end
end