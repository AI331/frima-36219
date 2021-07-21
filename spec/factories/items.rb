FactoryBot.define do
  factory :item do
    product_name { Faker::Games::Pokemon.name }
    description { Faker::Games::Pokemon.name }
    price { Faker::Number.between(from: 300, to: 999999) }
    category_id { Faker::Number.between(from: 2, to: 11) }
    status_id { Faker::Number.between(from: 2, to: 7) }
    burden_id { Faker::Number.between(from: 2, to: 2) } 
    delivery_id { Faker::Number.between(from: 2, to: 48) }
    days_delivery_id { Faker::Number.between(from: 2, to: 4) }
    association :user
  end
end
