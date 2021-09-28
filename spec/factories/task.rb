FactoryBot.define do
  factory :task do
    name { Faker::Task.name }
    description { Faker::Task.description }
    user { create(:user) }
  end
end