FactoryBot.define do
    factory :post do
      name { Faker::Lorem.sentence }
      content { Faker::Lorem.paragraph }
      association :user  # Ensures the post is associated with a user
    end
  end
  