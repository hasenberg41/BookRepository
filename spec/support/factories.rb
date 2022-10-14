FactoryBot.define do

  factory :author do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    age { rand(18..75) }
  end

  factory :book do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
  end
end
