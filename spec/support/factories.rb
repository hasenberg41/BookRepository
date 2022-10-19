FactoryBot.define do
  factory :author do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    age { rand(18..75) }
  end

  factory :book do
    title { Faker::Lorem.sentence[0..49] }
    description { Faker::Lorem.paragraph[0..499] }
    path { Faker::Internet.url }
  end

  factory :user do
    username { Faker::Name.name }
    password { ('a'..'z').to_a.union((1..9).to_a).sample(9).join }
    email { Faker::Internet.email }
  end
end
