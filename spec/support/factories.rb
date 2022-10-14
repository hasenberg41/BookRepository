FactoryBot.define do

  factory :author do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    age { rand(18..75) }
  end

  factory :book do
    title { Faker::Lorem.sentence[0..50] }
    description { Faker::Lorem.paragraph[0..500] }
  end

  factory :user do
    username { Faker::Name.first_name }
    password { ('a'..'z').to_a.union((1..9).to_a).shuffle[0..9].join }
  end
end
