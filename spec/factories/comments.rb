FactoryBot.define do
    factory :comment do
      content { Faker::Lorem.sentence }
      rating { rand(1..5) }
      association :post  # Ensures the comment is associated with a post
    end
  end
  