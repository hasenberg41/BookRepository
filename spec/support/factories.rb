FactoryBot.define do
  factory :book do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    author { Faker::Artist.name }
  end
end
